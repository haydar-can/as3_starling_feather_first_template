/**
 * Created by Haydar.Can on 14.10.2016.
 */
package view {

	import feathers.controls.Button;
	import feathers.controls.Drawers;
	import feathers.controls.StackScreenNavigator;
	import feathers.themes.MetalWorksMobileTheme;

	[Live]
	public class Main extends Drawers {

		private var _navigator:StackScreenNavigator;

		public function Main() {
			new MetalWorksMobileTheme();
			super();
		}

		override protected function initialize():void{
			super.initialize();
			this._navigator = new StackScreenNavigator();
			this.content = this._navigator;
			addButton();
		}
		[LiveCodeUpdateListener(method="addButton")]
		public function addButton():void {
			var btn:Button = new Button();
			btn.label = 'Merhaba Dünya';
			this.addChild(btn);
			btn.paddingTop = 200;
		}

	}
}
