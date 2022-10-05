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

#define PRINT(i, j) *((int *)(i)) = (j)
#define STOP while(1)


/**
 * @brief This test tests the scenraio where both cores try to capture the lock.
 * @attention The extra instructions can be commented in or our to provide some offset between the cores
 * 
 * @return 0xFFFFFF == fail
 */
int main(){
	int* leds = (int*)0x14;
	volatile int *status = (int*)734;
	volatile int *key_addr = (int *)ACCEL_A;
	volatile int *plaintext = (int *)ACCEL_B;
	volatile int *cyphertext = (int *)ACCEL_C;
	volatile int *ctrl_ptr = (int*)ACCEL_CTRL;
	volatile int *encryptor_lock = (int*)LOCK;
	if (CORE_INDEX == 0) {// core0
        // *status = 1; // Extra instruction
		*encryptor_lock = 1;
        if (*encryptor_lock == 0) {
            for (int i = 0; i < 4; i++) {
                key_addr[i] = 1;
                plaintext[i] = 1;
            }
            *ctrl_ptr = 1;
            while (*ctrl_ptr != ACCEL_DONE);
            if (cyphertext[0] != 0x66e94bd4 || cyphertext[1] != 0xef8a2c3b || cyphertext[2] != 0x884cfa59 || cyphertext[3] != 0xca342b2e)
                status = 0xFFFFFFFF;
        }
        while (1) PRINT(SEVSEG, *status);
	}
	else { //core1
        // *status = 1; // Extra instruction
        *encryptor_lock = 1;
        if (*encryptor_lock == 1) {
            for (int i = 0; i < 4; i++) {
                key_addr[i] = 0;
                plaintext[i] = 0;
            }
            *ctrl_ptr = 1;
            while (*ctrl_ptr != ACCEL_DONE);
            if (cyphertext[0] != 0x66e94bd4 || cyphertext[1] != 0xef8a2c3b || cyphertext[2] != 0x884cfa59 || cyphertext[3] != 0xca342b2e)
                status = 0xFFFFFFFF;
        }
        while (1);
	}
	STOP;
}