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


#define PRINT(i, j) *((int *)(i)) = (j)
#define STOP while(1)


int main(){
	int* leds = (int*)0x14;
	volatile int *addr = 700;
	*addr = 0x1;
	PRINT(LEDS, CORE_INDEX + 1);
	if (CORE_INDEX == 0) {// core0
		*addr *= 2;
		for (int i = 0; i < 10; i++) {
			PRINT(SEVSEG, *addr);
			PRINT(LEDS, i);
		}
	}
	else {
		for (int i = 0; i < 5; i++);
		*addr *= 2;
	}


	STOP;
}