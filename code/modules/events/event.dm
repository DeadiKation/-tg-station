/datum/event	//NOTE: Times are measured in master controller ticks!
	var/startWhen		= 0	//When in the lifetime to call start().
	var/announceWhen	= 0	//When in the lifetime to call announce().
	var/endWhen			= 0	//When in the lifetime the event should end. Include time for delayed announcements.
	var/oneShot			= 0	//If true, then the event removes itself from the list of potential events on creation.

	var/activeFor		= 0	//How long the event has existed. You don't need to change this.




//Called when the tick is equal to the startWhen variable.
//Allows you to announce before starting or vice versa.
//Only called once.
/datum/event/proc/start()
	return

//Called when the tick is equal to the announceWhen variable.
//Allows you to start before announcing or vice versa.
//Only called once.
/datum/event/proc/announce()
	return

//Called on or after the tick counter is equal to startWhen.
//You can include code related to your event or add your own
//time stamped events.
//Called more than once.
/datum/event/proc/tick()
	return

//Called on or after the tick is equal or more than endWhen
//You can include code related to the event ending.
//Do not place spawn() in here, instead use tick() to check for
//the activeFor variable.
//For example: if(activeFor == myOwnVariable + 30) doStuff()
//Only called once.
/datum/event/proc/end()
	return




//Do not override this proc, instead use the appropiate procs.
//This proc will handle the calls to the appropiate procs.
/datum/event/proc/process()
	if(activeFor == startWhen)
		start()

	if(activeFor > startWhen)
		tick()

	if(activeFor == announceWhen)
		announce()

	if(activeFor >= endWhen)
		end()
		kill()

	activeFor++


//Garbage collects the event by removing it from the global events list,
//which should be the only place it's referenced.
/datum/event/proc/kill()
	events.Remove(src)


//Adds the event to the global events list, and removes it from the list
//of potential events.
/datum/event/New()
	events.Add(src)

	if(oneShot)
		potentialRandomEvents.Remove(type)


//This shouldn't be called, but it ensures that the event doesn't persist in
//the events list if it'd deleted instead of garbage collected with kill().
//The master controller will also remove it from the events list if it
//doesn't exist, so there's redundancy here.
/datum/event/Del()
    events.Remove(src)