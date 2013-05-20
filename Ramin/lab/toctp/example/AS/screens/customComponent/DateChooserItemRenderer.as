package nl.caesar.pdsm.screens.customComponent
{
	import mx.controls.Alert;
	import mx.controls.DateField;
	import mx.controls.listClasses.IListItemRenderer;

	public class DateChooserItemRenderer extends DateField implements IListItemRenderer
	{
		public function DateChooserItemRenderer()
		{
			super();
			this.formatString = "DD-MM-YYYY";
			this.showToday = true;
		}
	}
}