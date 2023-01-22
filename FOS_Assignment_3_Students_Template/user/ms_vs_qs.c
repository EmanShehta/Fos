// hello, world
#include <inc/lib.h>

void
_main(void)
{
	char *str ;
	sys_createSemaphore("cs1", 1);

	sys_createSemaphore("dep1", 0);

	uint32 id1, id2;
	id2 = sys_create_env("qs_slave", (myEnv->page_WS_max_size),(myEnv->SecondListSize), (myEnv->percentage_of_WS_pages_to_be_removed));
	id1 = sys_create_env("ms_slave", (myEnv->page_WS_max_size),(myEnv->SecondListSize), (myEnv->percentage_of_WS_pages_to_be_removed));

	sys_run_env(id2);
	sys_run_env(id1);

	sys_waitSemaphore(myEnv->env_id, "dep1");
	sys_waitSemaphore(myEnv->env_id, "dep1");

	if (sys_getSemaphoreValue(myEnv->env_id, "dep1") != 0 || sys_getSemaphoreValue(myEnv->env_id, "cs1") != 1)
		panic("Wrong semaphore values...");
	else
		cprintf("Congratulations... ms vs qs run successfully\n");
}
