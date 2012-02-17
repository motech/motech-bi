/*
* Dispatched when the change button is clicked.
*/

package com.grameen.motech.pmt.dashboard.events
{
import flash.events.Event;

public class SearchEvent extends Event
{
	private var _year:String;
	private var _region:String;
	private var _district:String;
	
	public static var SEARCH:String = "search";
	
	public function SearchEvent(type:String, year:String=null, region:String=null, district:String=null)
	{
		super(type, true, true);
		_year = year;
		_region = region;
		_district = district;
	}

	public function get district():String
	{
		return _district;
	}

	public function set district(value:String):void
	{
		_district = value;
	}

	public function get region():String
	{
		return _region;
	}

	public function set region(value:String):void
	{
		_region = value;
	}

	public function get year():String
	{
		return _year;
	}

	public function set year(value:String):void
	{
		_year = value;
	}

}
}