package classes
{
	public class RoomClass
	{
		var titsClassPtr:*;

		//Refers to the object name
		private var _name:String;
		public function get name():String { return _name;}
		
		public static var needLoading:Array = new Array();
		
		//constructor
		public function RoomClass(titsClassPtrArg:*, name:String = "")
		{
			this.titsClassPtr = titsClassPtrArg;
			this._name = name;
			choices = new Array();
		}
		// include "consts.as";
		//data
		public var planet:String = "";
		//Used on inventory buttons
		public var system:String = "";
		//Room Name
		public var roomName:String = "";
		//Longass shit, not sure what used for yet.
		public var description:String = "";
		//Text used for tooltips when a room is discovered, but not visited yet
		public var teaserText:String = "An untold adventure awaits...";
		//runOnEnter holds functions that overlay the normal functioning
		public var runOnEnter = undefined;
				
		//Information
		public var moveMinutes:Number = 5;
		public var roomFlags:Array = new Array();
		
		public var choices:Array = new Array();
		
		//Exits - these point to the room key in rooms
		public var northExit:String = "";
		public var eastExit:String = "";
		public var southExit:String = "";
		public var westExit:String = "";
		public var inExit:String = "";
		public var inText:String = "In";
		public var outExit:String = "";
		public var outText:String = "Out";
		
		public function get exits():Array {
			var re:Array = new Array();
			if(northExit) re.push(titsClassPtr.rooms[northExit]);
			if(southExit) re.push(titsClassPtr.rooms[southExit]);
			if(eastExit) re.push(titsClassPtr.rooms[eastExit]);
			if(westExit) re.push(titsClassPtr.rooms[westExit]);
			return re;
		}

		public var canSaveInRoom:Boolean = true;
		
		public function get isCurrentLocation():Boolean {
			return name == kGAMECLASS.currentLocation;
		}
		
		public static function loadRoomFlags(save:Object, titsObj:TiTS):void {
			if(save.rooms == null) return;
			if(!save.rooms is Array) return;
			for each(var dataArray:Array in save.rooms) {
				titsObj.rooms[dataArray["name"]].loadFlags(dataArray);
			}
		}
		
		public static function saveRoomFlags(save:Object):void {
			var roomArr:Array = new Array();
			for each(var room:RoomClass in needLoading) {
				var dataArray:Array = new Array();
				dataArray["name"] = room.name;
				dataArray["discovered"] = !room.hasFlag(GLOBAL.UNDISCOVERED);
				dataArray["visited"] = !room.hasFlag(GLOBAL.UNVISITED);
				dataArray["reachable"] = !room.hasFlag(GLOBAL.UNREACHABLE);
				roomArr[room.name] = dataArray;
			}
			save.rooms = roomArr;
		}
		
		public static function updateRoomFlags(titsObj:TiTS):void {
			var room:RoomClass = titsObj.rooms[titsObj.currentLocation];
			if(room.hasFlag(GLOBAL.UNDISCOVERED)) room.removeFlag(GLOBAL.UNDISCOVERED);
			if(room.hasFlag(GLOBAL.UNVISITED)) room.removeFlag(GLOBAL.UNVISITED);
			if(room.hasFlag(GLOBAL.UNREACHABLE)) room.removeFlag(GLOBAL.UNREACHABLE);
			for each(var nextRoom:RoomClass in room.exits) {
				if(nextRoom.hasFlag(GLOBAL.UNREACHABLE)) continue;
				if(nextRoom.hasFlag(GLOBAL.UNDISCOVERED)) nextRoom.removeFlag(GLOBAL.UNDISCOVERED);
			}
		}
		
		//Functions
		public function hasFlag(arg):Boolean {
			return roomFlags.indexOf(arg) != -1;
		}
		public function addFlag(arg):void {
			if((arg == GLOBAL.UNDISCOVERED || arg == GLOBAL.UNVISITED || arg == GLOBAL.UNREACHABLE) && needLoading.indexOf(this) == -1) {
				needLoading.push(this);
			}
			if(hasFlag(arg)) return;
			roomFlags.push(arg);
		}
		public function removeFlag(arg):void {
			if(hasFlag(arg)) roomFlags.splice(roomFlags.indexOf(arg), 1);
		}
		public function loadFlags(dataArray:Array):void {
			if(dataArray["discovered"] != null) {
				if(dataArray["discovered"] && hasFlag(GLOBAL.UNDISCOVERED)) removeFlag(GLOBAL.UNDISCOVERED);
				if(!dataArray["discovered"] && !hasFlag(GLOBAL.UNDISCOVERED)) addFlag(GLOBAL.UNDISCOVERED);
			}
			if(dataArray["visited"] != null) {
				if(dataArray["visited"] && hasFlag(GLOBAL.UNVISITED)) removeFlag(GLOBAL.UNVISITED);
				if(!dataArray["visited"] && !hasFlag(GLOBAL.UNVISITED)) addFlag(GLOBAL.UNVISITED);
			}
			if(dataArray["reachable"] != null) {
				if(dataArray["reachable"] && hasFlag(GLOBAL.UNREACHABLE)) removeFlag(GLOBAL.UNREACHABLE);
				if(!dataArray["reachable"] && !hasFlag(GLOBAL.UNREACHABLE)) addFlag(GLOBAL.UNREACHABLE);
			}
		}
		public function toString():String
		{
			return "[Object RoomClass] " + name;
		}
	}
}