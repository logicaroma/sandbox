package nl.caesar.pdsm.model.UdeMap
{
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	
	[Bindable]
	[RemoteClass] 
	public class UdeMapAssumption extends UdeMapObject implements IExternalizable
	{
		public function UdeMapAssumption()
		{
		}
		
		public override function readExternal( input:IDataInput ):void {
			super.readExternal(input);
		}
		
		public override function writeExternal( output:IDataOutput ):void {
			super.writeExternal(output);
		}

	}
}