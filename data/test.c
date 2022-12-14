#define LEDS_BASE_ADDR 0x010
#define LEDS LEDS_BASE_ADDR 
#define SEVSEG (LEDS_BASE_ADDR +4)

#define ACCEL_BASE 0x020
#define ACCEL_CTRL ACCEL_BASE 
#define ACCEL_PERF_COUNTER (ACCEL_BASE + 0x4)
#define ACCEL_A (ACCEL_BASE + 0x8)
#define ACCEL_B (ACCEL_BASE + 0xc)
#define ACCEL_C (ACCEL_BASE + 0x10)


#define PRINT(i, j) *((int *)(i)) = (j)
#define STOP while(1)


int main(){
	int i = 0;
	int* leds = (int*)0x14;
	int* accel_ctrl_ptr = (int *)ACCEL_CTRL;
	int* accel_perf_ctr = (int *)ACCEL_PERF_COUNTER;
	int* accel_data_a_ptr = (int *)ACCEL_A;
	int* accel_data_b_ptr = (int *)ACCEL_B;
	int* accel_data_c_ptr = (int *)ACCEL_C;

	*accel_data_a_ptr = 0x00000105;
	*accel_data_b_ptr = 0x00000804;
	*accel_ctrl_ptr = 0x00000001; 
	PRINT(SEVSEG, *accel_perf_ctr);
	PRINT(SEVSEG, *accel_data_c_ptr);

	while(i<49){
		PRINT(LEDS, i);
		i++;
	}
	STOP;
}




// void lock_init(Lock *lock) {
// 	lock = 0;
// }

// lock (Lock *lock) {
// 	while(xchnge(*lock) == 1);
// }

// unlock(Lock *lock) {
// 	*lock = 0;
// }