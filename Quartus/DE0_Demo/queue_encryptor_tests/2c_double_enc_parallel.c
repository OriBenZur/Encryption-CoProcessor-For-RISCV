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
#define ACCEL_DONE 0x80000000
#define CHECK_POINT(val, counter) ((val) |= ((counter) << 1))

#define N_CORES 2

#define PRINT(i, j) *((int *)(i)) = (j)
#define STOP while(1)


/**
 * @brief In this test, one core encrypts the string 0x1\0x1\0x1\0x1 and core1 then encrypts core0's cyphertext
 * 
 * @return Last 8 LEDs on the MAX10 should be on, and the first 3 bytes of the final cyphertext should appear on the display
 */
int main(){
	int* leds = (int*)0x14;
	volatile int *buf = (int*)734;
	unsigned int *status = (unsigned int*)730;
	volatile int *key_addr = (int *)ACCEL_A;
	volatile int *plaintext = (int *)ACCEL_B;
	volatile int *cyphertext = (int *)ACCEL_C;
	volatile int *ctrl_ptr = (int*)ACCEL_CTRL;
	if (CORE_INDEX == 0) {// core0
		for (int i = 0; i < 4; i++) {
			key_addr[i] = 1;
			plaintext[i] = 1;
		}
		*ctrl_ptr = 1;
		while (*ctrl_ptr != ACCEL_DONE);
        for (int i = 0; i < 4; i++) {
            key_addr[i] = cyphertext[i];
            plaintext[i] = cyphertext[i];
        }
		*ctrl_ptr = 1;
		while (*ctrl_ptr != ACCEL_DONE);
		while(1) {
			PRINT(LEDS, *status);
			PRINT(SEVSEG, cyphertext[0]);
		}
	}
	else {
		unsigned int counter = 2;
		*status = counter; //1
		counter <<= 1;
        for (int i = 0; i < 4; i++) {
			key_addr[i] = 0;
			plaintext[i] = 0;
		}
		*ctrl_ptr = 1;
		while (*ctrl_ptr != ACCEL_DONE);
		key_addr[0] = 0x3e1f51ca;
		plaintext[0] = 0x3e1f51ca;
		key_addr[1] = 0xaf003131;
		plaintext[1] = 0xaf003131;
		key_addr[2] = 0x12144f8a;
		plaintext[2] = 0x12144f8a;
		key_addr[3] = 0x7f857bf6;
		plaintext[3] = 0x7f857bf6;
		*ctrl_ptr = 1;
		while (*ctrl_ptr != ACCEL_DONE);
		*status |= cyphertext[0] == 0x41de6075 ? counter : 0; //6
		counter <<= 1;
		*status |= cyphertext[1] == 0xb7865f61 ? counter : 0; //7
		counter <<= 1;
		*status |= cyphertext[2] == 0x79657635 ? counter : 0; //8
		counter <<= 1;
		*status |= cyphertext[3] == 0x5a43f327 ? counter : 0; //9
		*status |= 0x1; //0
		*buf = cyphertext[0];
	}
	STOP;
}