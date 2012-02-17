/*
* Base class for pod content.
*/

package com.grameen.motech.pmt.dashboard.view
{
import com.adobe.serialization.json.JSON;
import com.grameen.motech.pmt.dashboard.events.SearchEvent;

import flash.events.Event;
import flash.events.MouseEvent;
import flash.system.ApplicationDomain;
import flash.xml.XMLNode;

import mx.containers.VBox;
import mx.controls.Alert;
import mx.core.Application;
import mx.core.FlexGlobals;
import mx.events.FlexEvent;
import mx.events.IndexChangedEvent;
import mx.rpc.Fault;
import mx.rpc.events.FaultEvent;
import mx.rpc.events.ResultEvent;
import mx.rpc.http.HTTPService;
import mx.rpc.soap.WebService;
import mx.utils.ObjectProxy;

public class PodContentBase extends VBox
{
	[Bindable]
	public var properties:XML; // Properties are from pods.xml.
	
	// filters to be used to retrieve data from webservice 
	// TODO make dynamic by improving configuration
	private var _method:String;
	private var _year:String;
	private var _metric:String;
	private var _district:String;
	private var _region:String;
	private var _indicator:String;
	
	private var httpService:HTTPService = new HTTPService();
	
	function PodContentBase()
	{
		super();
		percentWidth = 100;
		percentHeight = 100;
		setStyle("paddingTop", "1");
		addEventListener(FlexEvent.CREATION_COMPLETE, onCreationComplete);
	}
	
	public function get indicator():String
	{
		return _indicator;
	}

	public function set indicator(value:String):void
	{
		_indicator = value;
	}

	public function get region():String
	{
		return _region;
	}

	public function set region(value:String):void
	{
		_region = value;
	}

	public function get district():String
	{
		return _district;
	}

	public function set district(value:String):void
	{
		_district = value;
	}

	public function get metric():String
	{
		return _metric;
	}

	public function set metric(value:String):void
	{
		_metric = value;
	}

	public function get year():String
	{
		return _year;
	}

	public function set year(value:String):void
	{
		_year = value;
	}

	public function get method():String
	{
		return _method;
	}

	public function set method(value:String):void
	{
		_method = value;
	}

	private function onCreationComplete(e:FlexEvent):void
	{
		// Load the data source.
		_method = properties.@method;
		_metric = properties.@metric;
		_indicator = properties.@indicator;
		
		if (_method && metric) {
			httpService.url = getURL();
			httpService.resultFormat = "object";
			httpService.addEventListener(FaultEvent.FAULT, onFaultHttpService);
			httpService.addEventListener(ResultEvent.RESULT, onResultHttpService);
			httpService.showBusyCursor = true;
			trace("calling webservice url:"+httpService.url);
			httpService.send();
		}
		FlexGlobals.topLevelApplication.searchButton.addEventListener(MouseEvent.CLICK, podSearchButton_ClickHandler);
		trace('listening for button click: '+this.hasEventListener(SearchEvent.SEARCH));
	}
	
	private function getURL(yr:String="2012", dist:String=null, rgn:String=null):String {
		var url:String = new String("http://www.motechghana.org/data/JSONServer.php");
		if (this.method != null && this.method != "")
			url = new String(url+"?params[method]="+_method);
		if (this.metric != null && this.metric != "")
			url = new String(url + "&params[metric]="+_metric);
		if (this.indicator != null && this.indicator != "")
			url = new String(url + "&params[indicator]="+_indicator);
		if (this.method != null && this.metric != null)
			url = new String(url + "&params[year]="+yr);
		if (dist)
			url = new String(url + "&params[district]="+dist);
		if (rgn)
			url = new String(url + "&params[region]="+rgn);
		return url;
		
	}
	
	private function onFaultHttpService(e:FaultEvent):void
	{
		var fault:Fault = e.fault;
		Alert.show("Unable to load data, " + fault.message + ".");
	}
	
	// abstract.
	protected function onResultHttpService(e:ResultEvent):void	{}
	
	// abstract. search button clicked
	protected function podSearchButton_ClickHandler(e:Event):void {
		
		httpService.url = getURL(FlexGlobals.topLevelApplication.YearCombo.selectedLabel, FlexGlobals.topLevelApplication.DistrictCombo.selectedLabel, FlexGlobals.topLevelApplication.RegionCombo.selectedLabel);
		httpService.send();
		
		trace("podSearchButton :"+httpService.url);
	}
	// Converts XML attributes in an XMLList to an Array.
	protected function xmlListToObjectArray(xmlList:XMLList):Array
	{
		var a:Array = new Array();
		for each(var xml:XML in xmlList)
		{
			var attributes:XMLList = xml.attributes();
			var o:Object = new Object();
			for each (var attribute:XML in attributes)
			{
				var nodeName:String = attribute.name().toString();
				var value:*;
				if (nodeName == "date")
				{
					var date:Date = new Date();
					date.setTime(Number(attribute.toString()));
					value = date;
				}
				else
				{
					value = attribute.toString();
				}
					
				o[nodeName] = value;
			}
			
			a.push(new ObjectProxy(o));
		}
		
		return a;
	}
	
	// transform JSON String to ActionScript Object Array
	protected function jsonToObjectArray(json:Object):Array {
		if (json == null || json == "") return [];
		var decoded:Object = JSON.decode(json as String);
		if (decoded.hasOwnProperty(_indicator))
				return decoded[_indicator] as Array;
		return [];
	}
	
	// Dispatches an event when the ViewStack index changes, which triggers a state save.
	// ViewStacks are only in ChartContent and FormContent.
	protected function dispatchViewStackChange(newIndex:Number):void
	{
		dispatchEvent(new IndexChangedEvent(IndexChangedEvent.CHANGE, true, false, null, -1, newIndex));
	}
}
}