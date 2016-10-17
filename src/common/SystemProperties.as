/**
 * Created by Haydar.Can on 14.10.2016.
 */
package common {
	import starling.utils.SystemUtil;

	public class SystemProperties{

		private static var _platform:String = SystemUtil.platform;

		public static function get platform():String {
			return _platform;
		}

		private static var _isDesktop:Boolean = SystemUtil.isDesktop;

		public static function get isDesktop():Boolean {
			return _isDesktop;
		}

		private var _orientation:String;

		public function get orientation():String {
			return _orientation;
		}

		public function set orientation(value:String):void {
			_orientation = value;
		}

		public function SystemProperties() {

		}
	}
}
