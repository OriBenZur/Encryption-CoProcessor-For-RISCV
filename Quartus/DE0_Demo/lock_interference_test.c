#define LEDS_BASE_ADDR 0x010
#define LEDS LEDS_BASE_ADDR 
#define SEVSEG (LEDS_BASE_ADDR +4)

#define CORE_INDEX (*((int*)0x20))
#define ACCEL_BASE 0x024
#define ACCEL_CTRL ACCEL_BASE 
#define ACCEL_PERF_COUNTER (ACCEL_BASE + 0x4)
#define ACCEL_A (ACCEL_BASE + 0x8)
#define ACCEL_B (ACCEL_BASE + 0x18)
#define ACCEL_C (ACCEL_BASE + 0x28)
#define LOCK (ACCEL_BASE + 0x38)
#define ACCEL_DONE 0x80000000

#define N_CORES 2

#define TEST_CORE 1

#define PRINT(i, j) *((int *)(i)) = (j)
#define STOP while(1)


/**
 * @brief This test tests encryption on one core, while the other tries to write to the accelerator and read from it.
 * 		The #define TEST_CORE determines which core is the one that performs the encryption
 * 
 * @return On the display, 1 == success, 0xFFFFFF == fail
 */
int main(){
	int* leds = (int*)0x14;
	volatile int *status = (int*)734;
	volatile int *key_addr = (int *)ACCEL_A;
	volatile int *plaintext = (int *)ACCEL_B;
	volatile int *cyphertext = (int *)ACCEL_C;
	volatile int *ctrl_ptr = (int*)ACCEL_CTRL;
	volatile int *encryptor_lock = (int*)LOCK;
	if (CORE_INDEX == TEST_CORE) {
		*encryptor_lock = 1;
		for (int i = 0; i < 4; i++) {
			key_addr[i] = 1;
			plaintext[i] = 1;
            for (int j = 0; j < 8; j++); // waste time
		}
		*ctrl_ptr = 1;
		while (*ctrl_ptr != ACCEL_DONE);
	}
	else {
        *status = 1;
        while(1) for (int i = 0; i < 4; i++) {
            key_addr[i] = 0x1234;
            plaintext[i] = 0x5678;
            *status = (key_addr[i] != 0 || plaintext[i] != 0) ? 0xFFFFFFFF : *status;
        }
	}
	while (1) PRINT(SEVSEG, *status);
}