package vortex.servers.rendering;

import vortex.servers.RenderingServer.IRenderingBackendImpl;
import vortex.utils.math.Rectanglei;

/**
 * The OpenGL rendering backend.
 */
class OpenGLBackend implements IRenderingBackendImpl {
    /**
     * Initializes this rendering backend.
     */
    public static function init():Void {
        
    }

    /**
     * Sets the values of the current viewport rectangle.
     */
    public static function setViewportRect(rect:Rectanglei):Void {
        
    }

    /**
     * Clears whatever is on-screen currently.
     */
    public static function clear():Void {

    }
 
    /**
     * Presents/renders whatever is on-screen currently.
     */
    public static function present():Void {

    }
}