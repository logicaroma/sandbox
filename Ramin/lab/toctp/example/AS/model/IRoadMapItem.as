package nl.caesar.pdsm.model
{
	
	public interface IRoadMapItem
	{
		function get roadMapId():String;
		
		function get order():Number;
		
		function set order( aOrder:Number ):void;
		
		function get responsible():String;
		
		function set responsible( aResponsible:String ):void;
		
		function get date():Date;
		
		function set date( aDate:Date ):void;
		
		function get description():String;
	}
}