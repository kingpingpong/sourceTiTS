package classes
{
	import classes.PlanetClass;
	
	public class RoomClass
	{
		//Refers to the object name
		private var _name:String;
		public function get name():String { return _name;}
		
		public static var needLoading:Array = new Array();
		
		//constructor
		public function RoomClass(name:String = "")
		{
			this._name = name;
			choices = new Array();
		}
		// include "consts.as";
		//data
		public var planet:PlanetClass;
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
		
		//Coordinates of room, relative to planet's hangar at 0,0,0
		public var x:int;
		public var y:int;
		public var z:int;
		
		//uid is the unique indentifier for each room
		//Due to digit restraints, there can only be 1000 x 1000 x 1000 rooms
		public function get uid():uint { return ((x + 500) * 1000000) + ((y + 500) * 1000) + (z + 500);}
				
		//Exits - these point to the room key in rooms
		public var northExit:String = "";
		public var eastExit:String = "";
		public var southExit:String = "";
		public var westExit:String = "";
		public var inExit:String = "";
		public var inText:String = "In";
		public var outExit:String = "";
		public var outText:String = "Out";
		
		public var hiddenExits:Array = new Array();
		
		public function get exits():Array {
			var re:Array = new Array();
			if(northExit && hiddenExits.indexOf(northExit) == -1) re.push(kGAMECLASS.rooms[northExit]);
			if(southExit && hiddenExits.indexOf(southExit) == -1) re.push(kGAMECLASS.rooms[southExit]);
			if(eastExit && hiddenExits.indexOf(eastExit) == -1) re.push(kGAMECLASS.rooms[eastExit]);
			if(westExit && hiddenExits.indexOf(westExit) == -1) re.push(kGAMECLASS.rooms[westExit]);
			if(inExit && hiddenExits.indexOf(inExit) == -1) re.push(kGAMECLASS.rooms[inExit]);
			if(outExit && hiddenExits.indexOf(outExit) == -1) re.push(kGAMECLASS.rooms[outExit]);
			return re;
		}
		
		public function getExit(exit:String):RoomClass {
			switch(exit) {
				case "n":
				case "north":
					return planet.rooms[northExit];
					break;
				case "s":
				case "south":
					return planet.rooms[southExit];
					break;
				case "e":
				case "east":
					return planet.rooms[eastExit];
					break;
				case "w":
				case "west":
					return planet.rooms[westExit];
					break;
				case "i":
				case "in":
					return planet.rooms[inExit];
					break;
				case "o":
				case "out":
					return planet.rooms[outExit];
					break;
			}
			return null;
		}

		public var canSaveInRoom:Boolean = true;
		
		public function get isCurrentLocation():Boolean {
			return name == kGAMECLASS.currentLocation;
		}
		
		public static function loadRoomFlags(save:Object):void {
			if(save.rooms == null || !(save.rooms is Array)) {
				PlanetClass.loadPlanets(kGAMECLASS);
				return;
			}
			for(var planet:String in save.rooms) {
				if(kGAMECLASS.planets[planet] == undefined) continue;
				for(var room:String in save.rooms[planet]) {
					var roomC:RoomClass = kGAMECLASS.planets[planet].getRoomById(room);
					if(roomC == null) continue;
					roomC.loadFlags(save.rooms[planet][room]);
				}
			}
		}
		
		public static function saveRoomFlags(save:Object):void {
			var planetArr:Array = new Array();
			for each(var room:RoomClass in needLoading) {
				var roomArray:Array;
				if(planetArr[room.planet.name] != null) roomArray = planetArr[room.planet.name];
				else {
					roomArray = new Array();
					planetArr[room.planet.name] = roomArray;
				}
				
				var dataArray:Array = new Array();
				dataArray["discovered"] = !room.hasFlag(GLOBAL.UNDISCOVERED);
				dataArray["visited"] = !room.hasFlag(GLOBAL.UNVISITED);
				dataArray["reachable"] = !room.hasFlag(GLOBAL.UNREACHABLE);
				if(roomArray[room.uid] != null) trace(room.uid + " bad");
				roomArray[room.uid] = dataArray;
				
			}
			var i:int = 0;
			for(var planet:String in planetArr) {
				for(var roomStr:String in planetArr[planet]) {
					i++;
				}
				trace("Planet saved: " + planet + " rooms: " + i);
				i = 0;
			}
			save.rooms = planetArr;
		}
		
		public static function updateRoomFlags():void {
			var room:RoomClass = kGAMECLASS.rooms[kGAMECLASS.currentLocation];
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