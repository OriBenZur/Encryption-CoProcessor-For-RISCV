#define LEDS_BASE_ADDR 0x010
#define LEDS LEDS_BASE_ADDR 
#define SEVSEG (LEDS_BASE_ADDR +4)

#define ACCEL_BASE 0x020
#define ACCEL_CTRL ACCEL_BASE 
#define ACCEL_PERF_COUNTER (ACCEL_BASE + 0x4)
#define ACCEL_A (ACCEL_BASE + 0x8)
#define ACCEL_B (ACCEL_BASE + 0x18)
#define ACCEL_C (ACCEL_BASE + 0x28)
#define LOCK 0x54
#define ACCEL_DONE 0x80000000
#define CHECK_POINT(val, counter) ((val) |= ((counter) << 1))

#define N_CORES 2

#define PRINT(i, j) *((int *)(i)) = (j)
#define STOP while(1)


int main(){
	int* leds = (int*)0x14;
	// *buf = 0;
	int val = 0x03;
	PRINT(SEVSEG, val);
	if ((unsigned int)(&leds) > 700) {
		val = 0x16;
		PRINT(LEDS, val);
	}
	STOP;
}

// volatile int *buf = (int*)704;
		// volatile int *key_addr = (int *)ACCEL_A;
		// volatile int *plaintext = (int *)ACCEL_B;
		// volatile int *cyphertext = (int *)ACCEL_C;
		// volatile int *ctrl_ptr = (int*)ACCEL_CTRL;
		// volatile int *encryptor_lock = (int*)LOCK;
		// int temp;
		// int counter = 1;
		// int led_val = 1; //0
		// PRINT(LEDS, led_val);
		// temp = *encryptor_lock;
		// *encryptor_lock = 1;
		// counter <<= 1;
		// if (*encryptor_lock == 0 && temp == 2)
		// 	led_val |= counter; //1
		// counter <<= 1;
		// for (int i = 0; i < 4; i++) {
		// 	key_addr[i] = 1;
		// 	plaintext[i] = 1;
		// 	if (key_addr[i] == 1 && plaintext[i] == 1)
		// 		led_val |= counter;//2.3.4.5
		// 	counter <<= 1;
		// }
		// *ctrl_ptr = 1;
		// PRINT(LEDS, led_val);
		// while (*ctrl_ptr != ACCEL_DONE);
		// led_val |= cyphertext[0] == 0x3e1f51ca ? counter : 0; //6
		// counter <<= 1;
		// led_val |= cyphertext[1] == 0xaf003131 ? counter : 0; //7
		// counter <<= 1;
		// led_val |= cyphertext[2] == 0x12144f8a ? counter : 0; //8
		// counter <<= 1;
		// led_val |= cyphertext[3] == 0x7f857bf6 ? counter : 0; //9
		// *encryptor_lock = 0;
		// PRINT(LEDS, led_val);
		// PRINT(SEVSEG, *encryptor_lock + 1);

		// for (int i = 0; i < 4; i++) buf[i] = cyphertext[i];
		// PRINT(SEVSEG, (buf[0] & ~0xf) | (*encryptor_lock & 0xf));
		// while(1) PRINT(LEDS, *status);
	// }
	// else {
		// int counter = 1;
		// while (*buf == 0);
		// *status |= counter; //0
		// counter <<= 1;
		// while (*encryptor_lock != N_CORES);
		// *status |= counter; //1
		// counter <<= 1;
		// *encryptor_lock = 1;
		// if (*encryptor_lock == 1) {
		// 	*status |= counter; //2
		// }
		// counter <<= 1;
		// for (int i = 0; i < 4; i++) {
		// 	key_addr[i] = buf[i];
		// 	plaintext[i] = buf[i];
		// 	if (key_addr[i] == buf[i] && plaintext[i] == buf[i]) {
		// 		*status |= counter; //3.4.5.6
		// 	}
		// 	counter <<= 1;
		// }
		// while (*ctrl_ptr != ACCEL_DONE);
		// *status |= cyphertext[0] == 0x41de6075 ? counter : 0; //7
		// counter <<= 1;
		// *status |= cyphertext[1] == 0xb7865f61 ? counter : 0; //8
		// counter <<= 1;
		// // *status |= cyphertext[2] == 0x79657635 ? counter : 0; //9
		// // counter <<= 1;
		// *status |= cyphertext[3] == 0x5a43f327 ? counter : 0; //9
	// }