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
#define CHECK_POINT(val, counter) ((val) |= ((counter) << 1))

#define N_CORES 2

#define PRINT(i, j) *((int *)(i)) = (j)
#define STOP while(1)


/**
 * @brief In this test, one core encrypts the string 0x1\0x1\0x1\0x1 and core1 then encrypts core0's cyphertext
 * 
 * @return All 9 LEDs on the MAX10 should be on, and the first 3 bytes of the final cyphertext should appear on the display
 */
int main(){
	int* leds = (int*)0x14;
	volatile int *buf = (int*)734;
	unsigned int *status = (unsigned int*)730;
	volatile int *key_addr = (int *)ACCEL_A;
	volatile int *plaintext = (int *)ACCEL_B;
	volatile int *cyphertext = (int *)ACCEL_C;
	volatile int *ctrl_ptr = (int*)ACCEL_CTRL;
	volatile int *encryptor_lock = (int*)LOCK;
	if (CORE_INDEX == 0) {// core0
		*encryptor_lock = 1;
		for (int i = 0; i < 4; i++) {
			key_addr[i] = 1;
			plaintext[i] = 1;
		}
		*ctrl_ptr = 1;
		while (*ctrl_ptr != ACCEL_DONE);
		for (int i = 0; i < 4; i++)
			buf[i] = cyphertext[i];
		*encryptor_lock = 0;
		while(1) {
			PRINT(LEDS, *status);
			PRINT(SEVSEG, buf[0]);
		}
	}
	else {
		unsigned int counter = 1;
		*buf = 0;
		while (*buf == 0);
		while (*encryptor_lock != N_CORES);
		*status = counter; //0
		counter <<= 1;
		*encryptor_lock = 1;
		if (*encryptor_lock == 1) {
			*status |= counter; //1
		}
		counter <<= 1;
		for (int i = 0; i < 4; i++) {
			key_addr[i] = buf[i];
			plaintext[i] = buf[i];
			if (key_addr[i] == buf[i] && plaintext[i] == buf[i]) {
				*status |= counter; //2,3,4,5
			}
			counter <<= 1;
		}
		*ctrl_ptr = 1;
		while (*ctrl_ptr != ACCEL_DONE);
		*status |= cyphertext[0] == 0x41de6075 ? counter : 0; //6
		counter <<= 1;
		*status |= cyphertext[1] == 0xb7865f61 ? counter : 0; //7
		counter <<= 1;
		*status |= cyphertext[2] == 0x79657635 ? counter : 0; //8
		counter <<= 1;
		*status |= cyphertext[3] == 0x5a43f327 ? counter : 0; //9
		*buf = cyphertext[0];
	}
	STOP;
}