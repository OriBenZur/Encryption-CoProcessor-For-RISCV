#define LEDS_BASE_ADDR 0x010
#define LEDS LEDS_BASE_ADDR 
#define SEVSEG (LEDS_BASE_ADDR +4)

#define ACCEL_BASE 0x020
#define ACCEL_CTRL ACCEL_BASE 
#define ACCEL_PERF_COUNTER (ACCEL_BASE + 0x4)
#define ACCEL_A (ACCEL_BASE + 0x8)
#define ACCEL_B (ACCEL_BASE + 0x18)
#define ACCEL_C (ACCEL_BASE + 0x28)
#define ACCEL_DONE 0x80000000


#define PRINT(i, j) *((int *)(i)) = (j)
#define STOP while(1)


int main(){
	int i = 0;
	int* leds = (int*)0x14;
	int addr = 0x01010101;
	if ((unsigned int)(&leds) > 700) {// core0
		addr *= 2;
		for (int i = 0; i < 1000; i++);
		PRINT(SEVSEG, *addr);
		// PRINT(LEDS, 3);
	}
	else {
		for (int i = 0; i < 1000; i++);
		// *(char*)(702) = 0x34;
		// *(char*)(703) = 0x34;
	}

	STOP;
}


// void encryptor_init() {
// 	encryptor.key_addr = (int *)ACCEL_A;
// 	encryptor.plaintext = (int *)ACCEL_B;
// 	encryptor.cyphertext = (int *)ACCEL_C;
// 	encryptor.ctrl_ptr = (int*)ACCEL_CTRL;
// 	encryptor.perf_ctr = (int*)ACCEL_PERF_COUNTER;
// }


// void atomic_encrypt(int *key, int *plaintext, int *cyphertext) {
// 	for (int i = 0; i < 4; i++) {
// 		encryptor.key_addr[i] = key[i];
// 		encryptor.plaintext[i] = plaintext[i];
// 	}
// 	*encryptor.ctrl_ptr = 1;
// 	PRINT(LEDS, 1);
// 	while (*encryptor.ctrl_ptr != ACCEL_DONE);
// 	PRINT(LEDS, 2);
// 	for (int i = 0; i < 4; i++) cyphertext[i] = encryptor.cyphertext[i];
// }


// void lock_init(Lock *lock) {
// 	lock = 0;
// }

// lock (Lock *lock) {
// 	while(xchnge(*lock) == 1);
// }

// unlock(Lock *lock) {
// 	*lock = 0;
// }