package com.grameen.motech.pmt.dashboard.vo
{
	import mx.collections.ArrayCollection;

	public class Location
	{
		public function Location()
		{
		}
		
		private var _label:String;
		private var _value:String;
		[ArrayElementType("com.grameen.motech.pmt.dashboard.vo.Location")]
		private var _subLocation:ArrayCollection;

		public function get subLocation():ArrayCollection
		{
			return _subLocation;
		}

		public function set subLocation(value:ArrayCollection):void
		{
			_subLocation = value;
		}

		public function get value():String
		{
			return _value;
		}

		public function set value(value:String):void
		{
			_value = value;
		}

		public function get label():String
		{
			return _label;
		}

		public function set label(value:String):void
		{
			_label = value;
		}

	}
}