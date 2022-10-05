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

// struct Encryptor {
// 	int key_addr[4];
// 	int plaintext[4];
// 	int cyphertext[4];
// 	int ctrl_ptr[1];
// 	int perf_ctr[1];
// };

/**
 * @brief This test was 
 * @attention This test was retrofitted to comply with the final design.
 * @return The first 3 bytes of the cyphertext should appear on the display
 */
int main(){
	if (CORE_INDEX == 0) {
		int* leds = (int*)0x14;
		int *key_addr = (int *)ACCEL_A;
		int *plaintext = (int *)ACCEL_B;
		int *cyphertext = (int *)ACCEL_C;
		int *ctrl_ptr = (int*)ACCEL_CTRL;
		int *perf_ctr = (int*)ACCEL_PERF_COUNTER;
		PRINT(LEDS, 2);
		for (int i = 0; i < 4; i++) {
			key_addr[i] = (5 << (i << 2)) + i;
			plaintext[i] = (7 << (i << 1)) + i;
		}
		*ctrl_ptr = 1;
		while (*ctrl_ptr != ACCEL_DONE);
		PRINT(SEVSEG, *cyphertext);
	}
	STOP;
}