function ScheduleWeeklyPage(_Y) {
	this.Y = _Y;
}

ScheduleWeeklyPage.prototype.makeJobDraggable = function(/*String*/ prefix, /*String*/ eventId, /*String*/ room, /*String*/ day,  /*String*/ jobId) {
	var handleId = prefix + '_job_' + eventId;
	if (document.getElementById(handleId) == null) {
		return;
	}
	var jobDragHandle = this.Y.one(document.getElementById(handleId));
	var _Y = this.Y;
	var drag = new this.Y.DD.Drag({
		node : jobDragHandle,
    	move : false,
    	data : {
    		eventId : eventId,
    		jobId: jobId,
    		day : day,
    		room : room
    	}
	});
}
		
ScheduleWeeklyPage.prototype.makeRoomDroppable = function(/*String*/ prefix, /*String*/ targetDate, /*String*/ targetRoom) {
	var roomId = targetRoom.replace(new RegExp(/\s/g),'').replace(new RegExp(/&/g),'');
	var handleId = prefix + '_room_' + targetDate + '_' + roomId;
	var roomDropHandle = this.Y.one(document.getElementById(handleId));
	var _Y = this.Y;
	var drop = new this.Y.DD.Drop({
        node : roomDropHandle
    });
    drop.set('targetRoom', targetRoom);
    drop.set('targetDate', targetDate);
    drop.on('drop:hit', function(e) {
        var drag = e.drag;
        var data = drag.get('data');
        var eventId = data.eventId;
        var jobId = data.jobId;
        var sourceDate = data.day;
        var sourceRoom = data.room;
        moveJobToRoom(jobId, sourceRoom, targetRoom, sourceDate, targetDate);
    });
}