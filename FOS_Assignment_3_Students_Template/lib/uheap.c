#include <inc/lib.h>

// malloc()
//	This function use FIRST FIT strategy to allocate space in heap
//  with the given size and return void pointer to the start of the allocated space

//	To do this, we need to switch to the kernel, allocate the required space
//	in Page File then switch back to the user again.
//
//	We can use sys_allocateMem(uint32 virtual_address, uint32 size); which
//		switches to the kernel mode, calls allocateMem(struct Env* e, uint32 virtual_address, uint32 size) in
//		"memory_manager.c", then switch back to the user mode here
//	the allocateMem function is empty, make sure to implement it.

//==================================================================================//
//============================ REQUIRED FUNCTIONS ==================================//
//==================================================================================//
int Mem[(USER_HEAP_MAX - USER_HEAP_START) / PAGE_SIZE] = { 0 };
int idx1 = 0;
int idx2 = 0;
struct Free_pages {
	int Address;
	int size;
}free_pages[(USER_HEAP_MAX - USER_HEAP_START) / PAGE_SIZE],
		allocated_pages[(USER_HEAP_MAX - USER_HEAP_START) / PAGE_SIZE];
void* malloc(uint32 size)
{
	int mini = 5000000;
	int start_address = -1;
	idx1=0;
	size = ROUNDUP(size,PAGE_SIZE)/ PAGE_SIZE;
	for (int i = 0; i < (USER_HEAP_MAX - USER_HEAP_START) / PAGE_SIZE ; i++) {
		int counter_pages = 0;
		int temp = i;
		int check_free = 0;
		while (Mem[i] == 0 && i <(USER_HEAP_MAX - USER_HEAP_START) / PAGE_SIZE ) {
			counter_pages++;
			i++;
			check_free =1;
		}
		if (check_free==1) {
				free_pages[idx1].Address = USER_HEAP_START + (temp * PAGE_SIZE);
				free_pages[idx1].size = counter_pages;
				idx1++;
				check_free = 0;
		}
	}
	for (int i = 0; i < idx1; i++) {
		if (free_pages[i].size >= size && free_pages[i].size < mini) {
			mini = free_pages[i].size ;
			start_address = free_pages[i].Address;
		}
	}
	if(start_address==-1)
		return NULL;
	int index = (start_address - USER_HEAP_START) / PAGE_SIZE;
	for (int i = index; i < index+size; i++) {
		Mem[i] = 1;
	}
	allocated_pages[idx2].Address = start_address;
	allocated_pages[idx2].size= size;
	idx2++;
	sys_allocateMem(start_address,size*PAGE_SIZE);
	return (void *) start_address;

}
// free():
//	This function frees the allocation of the given virtual_address
//	To do this, we need to switch to the kernel, free the pages AND "EMPTY" PAGE TABLES
//	from page file and main memory then switch back to the user again.
//
//	We can use sys_freeMem(uint32 virtual_address, uint32 size); which
//		switches to the kernel mode, calls freeMem (struct Env* e, uint32 virtual_address, uint32 size) in
//		"memory_manager.c", then switch back to the user mode here
//	the freeMem function is empty, make sure to implement it.

void free(void* virtual_address) {
	int temp = 0;
	for (int i = 0; i < idx2; i++) {
		if (allocated_pages[i].Address == (int) virtual_address) {
			temp = i;
			break;
		}
	}
	int index = ((int) virtual_address - USER_HEAP_START) / PAGE_SIZE;
	for (uint32 i = index; i < index+allocated_pages[temp].size; i++) {
		Mem[i] = 0;
	}
	sys_freeMem((int) virtual_address, allocated_pages[temp].size * PAGE_SIZE);
	for(int i  = temp ; i < idx2-1 ;i++)
	{
		allocated_pages[i].Address =allocated_pages[i+1].Address;
		allocated_pages[i].size =allocated_pages[i+1].size;
	}
	idx2--;
}

//==================================================================================//
//================================ OTHER FUNCTIONS =================================//
//==================================================================================//

void* smalloc(char *sharedVarName, uint32 size, uint8 isWritable) {
	panic("this function is not required...!!");
	return 0;
}

void* sget(int32 ownerEnvID, char *sharedVarName) {
	panic("this function is not required...!!");
	return 0;
}

void sfree(void* virtual_address) {
	panic("this function is not required...!!");
}

void *realloc(void *virtual_address, uint32 new_size) {
	panic("this function is not required...!!");
	return 0;
}

void expand(uint32 newSize) {
	panic("this function is not required...!!");
}
void shrink(uint32 newSize) {
	panic("this function is not required...!!");
}

void freeHeap(void* virtual_address) {
	panic("this function is not required...!!");
}
