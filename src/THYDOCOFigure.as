package {

    import com.demonsters.debugger.MonsterDebugger;
    import com.demonsters.debugger.MonsterDebuggerUtils;

    import common.SystemProperties;

    import common.SystemProperties;

    import feathers.utils.ScreenDensityScaleFactorManager;

    import flash.display.Loader;

    import flash.display.Sprite;
    import flash.display.StageAlign;
	import flash.display.StageAspectRatio;
	import flash.display.StageDisplayState;
	import flash.display.StageScaleMode;
    import flash.display3D.Context3DProfile;
    import flash.display3D.Context3DRenderMode;
    import flash.events.Event;
    import flash.geom.Rectangle;
	import flash.system.Capabilities;
    import flash.system.System;

    import starling.core.Starling;
    import starling.events.Event;
    import starling.utils.RectangleUtil;
    import starling.utils.ScaleMode;

    import view.Main;

    [SWF(width="960", height="640", frameRate="60", backgroundColor="#4a4137")]
    public class THYDOCOFigure extends Sprite {

        private var _starling:Starling;
        private var _scaler:ScreenDensityScaleFactorManager;
        private var _launchImage:Loader;
        private var _savedAutoOrients:Boolean = true;

        public function THYDOCOFigure() {
            if(this.stage){
                this.stage.scaleMode = StageScaleMode.NO_SCALE;
                this.stage.align = StageAlign.TOP_LEFT;
				if(SystemProperties.platform != 'WIN'){
                    this.stage.displayState = StageDisplayState.FULL_SCREEN_INTERACTIVE;

                }else{
                    this.stage.displayState = StageDisplayState.NORMAL;
                }
            }
            this.mouseEnabled = this.mouseChildren = false;
            this.showLaunchImage();
            this.loaderInfo.addEventListener(flash.events.Event.COMPLETE, loaderInfo_completed);
            MonsterDebugger.initialize(this);
            MonsterDebugger.trace(this, 'Merhaba debugger');
            MonsterDebugger.trace(this, SystemProperties.platform);
        }

        private function loaderInfo_completed(event:flash.events.Event):void {

            Starling.multitouchEnabled = true;

            var stageSize:Rectangle = new Rectangle(0,0, stage.stageWidth, stage.stageHeight);
            var screenSize:Rectangle = new Rectangle(0,0, stage.fullScreenWidth, stage.fullScreenHeight);
            var viewPort:Rectangle = RectangleUtil.fit(stageSize, screenSize, ScaleMode.SHOW_ALL, SystemProperties.platform == 'IOS');

            this._starling = new Starling(Main, this.stage, viewPort, null, Context3DRenderMode.AUTO, Context3DProfile.BASELINE);
            this._starling.supportHighResolutions = true;
            this._starling.skipUnchangedFrames = true;
            this._starling.simulateMultitouch = true;
            MonsterDebugger.trace(this, this._starling);

            /**
             * DEBUG modunda starling yardımcıları açılıyor...
             * */
            if(Capabilities.isDebugger){
                this._starling.enableErrorChecking = true;
                this._starling.showStats = true;
            }

            this._starling.start();

            System.pauseForGCIfCollectionImminent(0);
            System.gc();

            if(this._launchImage){

            }
            this._scaler = new ScreenDensityScaleFactorManager(this._starling);

            this._starling.addEventListener(starling.events.Event.ROOT_CREATED, rootCreated);
            this.stage.addEventListener(flash.events.Event.DEACTIVATE, stage_deactive, false, 0, true);
            this.stage.addEventListener(flash.events.Event.RESIZE, stageResize)
        }

        private function stageResize(event:flash.events.Event):void {
            var viewPortRectangle:Rectangle = new flash.geom.Rectangle();
            viewPortRectangle.width = this.stage.stageWidth;
            viewPortRectangle.height = this.stage.stageHeight;

            Starling.current.viewPort = viewPortRectangle;

            this._starling.stage.stageWidth = this.stage.stageWidth;
            this._starling.stage.stageHeight = this.stage.stageHeight;
			this._scaler = new ScreenDensityScaleFactorManager(this._starling);
        }

        private function stage_deactive(event:flash.events.Event):void {
            System.gc();
            this._starling.stop(true);
            this.stage.addEventListener(flash.events.Event.ACTIVATE, stage_active, false, 0, true);
        }

        private function stage_active(event:flash.events.Event):void {
            this.stage.removeEventListener(flash.events.Event.ACTIVATE, stage_active);
            this._starling.start();
        }

        private function rootCreated(event:starling.events.Event):void {
            this.stage.autoOrients = this._savedAutoOrients;
			this.stage.setAspectRatio(StageAspectRatio.ANY)
        }

        private function showLaunchImage():void {

        }
    }
}
