package vortex.backend;

#if !macro
import cpp.UInt64;

import vortex.servers.RenderingServer;
import vortex.utils.math.Vector2i;

import sdl.SDL;
import sdl.Types;

import vortex.backend.Window;
import vortex.utils.generic.CFGParser;
import vortex.utils.engine.Project.ProjectInfo;
import vortex.macros.ProjectMacro;

/**
 * The very base of your games!
 */
@:access(vortex.backend.Window)
@:autoBuild(vortex.macros.ApplicationMacro.build())
class Application {
	/**
	 * The current application instance.
	 */
	public static var self:Application;

	/**
	 * The metadata of the project config.
	 */
	public var meta:ProjectInfo;

	/**
	 * The main window of this application.
	 */
	public var window:Window;

	/**
	 * All of the windows attached to this application.
	 */
	public var windows:Array<Window> = [];

	/**
	 * Makes a new `Application`.
	 */
	public function new() {
		if(self == null)
			self = this;
		
		meta = CFGParser.parse(ProjectMacro.getConfig());

		if(SDL.init(VIDEO | EVENTS) < 0) {
			Debug.error(SDL.getError());
			return;
		}

		window = new Window(meta.window.title, new Vector2i(WindowPos.CENTERED, WindowPos.CENTERED), new Vector2i().copyFrom(meta.window.size));
		RenderingServer.init();
	}

	public function startEventLoop() {
		Window._ev = SDL.makeEvent();
		
		var curTime:UInt64 = SDL.getPerformanceCounter();
		var oldTime:UInt64 = 0;

		while(windows.length != 0) {
			oldTime = curTime;
			curTime = SDL.getPerformanceCounter();
			Engine.deltaTime = untyped __cpp__("(double)({0} - {1}) / (double){2}", curTime, oldTime, SDL.getPerformanceFrequency());

			var i:Int = 0;
			while(i < windows.length) {
				final window:Window = windows[i++];
				if(window != null) {
					RenderingServer.clear(window);

					window.tickAll(Engine.deltaTime);
					window.drawAll();
					
					RenderingServer.present(window);
				}
			}
		}
		
		RenderingServer.dispose();
		window.dispose();

		SDL.quit();
	}
}
#else
class Application {
	public function new() {}
}
#end