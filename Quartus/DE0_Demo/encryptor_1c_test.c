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

struct Encryptor {
	int *key_addr;
	int *plaintext;
	int *cyphertext;
	int *ctrl_ptr;
	int *perf_ctr;
};

// volatile struct Encryptor encryptor;
// void atomic_encrypt(int *key, int *plaintext, int *cyphertext);
// void encryptor_init();


int main(){
	int i = 0;
	int* leds = (int*)0x14;
	// int key[4] = {0};
	// int plaintext[4] = {0};
	// int cyphertext[4] = {0};
	int *key_addr = (int *)ACCEL_A;
	int *plaintext = (int *)ACCEL_B;
	int *cyphertext = (int *)ACCEL_C;
	int *ctrl_ptr = (int*)ACCEL_CTRL;
	int *perf_ctr = (int*)ACCEL_PERF_COUNTER;
	PRINT(LEDS, 2);
	for (int i = 0; i < 4; i++) {
		key_addr[i] = 0;
		plaintext[i] = 0;
	}
	*ctrl_ptr = 1;
	while (*ctrl_ptr != ACCEL_DONE);
	// encryptor_init();
	// atomic_encrypt(key, plaintext, cyphertext);
	PRINT(SEVSEG, *cyphertext);
	PRINT(LEDS, 3);
	// for (int i = 0; i < 4; i+=2)
		// PRINT(SEVSEG, *(cyphertext + i));
	// while(i<49){
	// 	PRINT(LEDS, i);
	// 	i++;
	// }
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