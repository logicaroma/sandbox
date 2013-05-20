package nl.caesar.pdsm.components
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.ui.Keyboard;
	
	import mx.containers.Canvas;
	import mx.controls.Button;
	import mx.managers.CursorManager;
	
	public class ResizableCanvas extends Canvas
	{
		// right edge of the canvas
		private var _rightEdge:Button;
		// bottom edge of the canvas
		private var _bottomEdge:Button;
		// both edges (bottom-right corner) of the canvas
		private var _bothEdges:Button;
		// the cursor id
		private var _currentCursorId:int;
		// true if the horizontal drag started
		private var _dragHStarted:Boolean;
		// true if the vertical drag started
		private var _dragVStarted:Boolean;
		// the position before starting to drag
		private var _dragStartHPosition:int;
		// the position before starting to drag
		private var _dragStartVPosition:int;
		// last width of our canvas before starting to drag
		private var _dragLastWidth:int;
		// last height of our canvas before starting to drag
		private var _dragLastHeight:int;
		// is resizable horizontally
		private var _isResizableHorizontally:Boolean;
		// is resizable vertically
		private var _isResizableVertically:Boolean;
		// is resizing
		private var _isResizing:Boolean;
		
		// cursor image (horizontal)
		[Embed("nl/caesar/pdsm/components/resources/img/h_resize.gif")]
		private var _hResizeCursor:Class;
		// cursor image (vertical)
		[Embed("nl/caesar/pdsm/components/resources/img/v_resize.gif")]
		private var _vResizeCursor:Class;
		// cursor image (both)
		[Embed("nl/caesar/pdsm/components/resources/img/c_resize.gif")]
		private var _cResizeCursor:Class;
	
		// Constructor
		public function ResizableCanvas(hResizable:Boolean = true, vResizable:Boolean = true):void
		{
			super();
			// initialization
			_dragHStarted = false;
			_dragVStarted = false;
			_isResizing = false
			_dragStartHPosition = 0;
			_dragStartVPosition = 0;
			_currentCursorId = -1;
			// by default our canvas is resizable horizontally
			horizontalResizable = hResizable;
			verticalResizable = vResizable;
			this.addEventListener(KeyboardEvent.KEY_DOWN, handleKeyDown);
		}
		
	
		// setter to enable/disable the horizontal resize functionality
		public function set horizontalResizable(value:Boolean):void
		{
			// if the value is changed
			if (value != _isResizableHorizontally)
			{
				if (value)
				{
					// horizontalResizable = true

					// we add the right edge which is a button
					_rightEdge = new Button();
					// no label
					_rightEdge.label = "";
					// no tooltip
					_rightEdge.toolTip = null;
					_rightEdge.tabEnabled = false;
					_rightEdge.setStyle("right", 0);
					_rightEdge.setStyle("verticalCenter",0);
					_rightEdge.percentHeight = 90;
					_rightEdge.width = 9;
					// set its style
					// in this style we set the skin to not show anything
					_rightEdge.styleName = "canvasRightEdge";
					
					// used to display the resize icon
					_rightEdge.addEventListener(MouseEvent.MOUSE_OVER, handleHResizeOver, false, 0 ,true);
					// used to display the resize icon
					_rightEdge.addEventListener(MouseEvent.MOUSE_MOVE, handleHResizeOver, false, 0 ,true);
					// used to hide the resize icon
					_rightEdge.addEventListener(MouseEvent.MOUSE_OUT, handleResizeOut, false, 0 ,true);
					// used to start the drag
					// we save the initial position and width
					_rightEdge.addEventListener(MouseEvent.MOUSE_DOWN, handleHDragStart, false, 0 ,true);
					// used for real rezise and other important stuff
					_rightEdge.addEventListener(Event.ENTER_FRAME, handleHDragMove, false, 0 ,true);
					// used to stop the drag - mouse up on the edge
					_rightEdge.addEventListener(MouseEvent.MOUSE_UP, handleDragStop, false, 0 ,true);
					
					addChild(_rightEdge);
					
					// if the right-bottom button is already added
					if (!_bothEdges)
					{
						// we add the right bottom button
						_bothEdges = new Button();
						// no label
						_bothEdges.label = "";
						// no tooltip
						_bothEdges.toolTip = null;
						_bothEdges.tabEnabled = false;
						_bothEdges.setStyle("right", 0);
						_bothEdges.setStyle("bottom",0);
						_bothEdges.height = 12;
						_bothEdges.width = 12;
						// set its style
						// in this style we set the skin to not show anything
						_bothEdges.styleName = "canvasBothEdges";
						
						// if the canvas is only horizontally resizable
						// we use the same events and handlers like in that case
						_bothEdges.addEventListener(MouseEvent.MOUSE_OVER, handleBothResizeOver, false, 0 ,true);
						_bothEdges.addEventListener(MouseEvent.MOUSE_MOVE, handleBothResizeOver, false, 0 ,true);
						_bothEdges.addEventListener(MouseEvent.MOUSE_OUT, handleResizeOut, false, 0 ,true);
						_bothEdges.addEventListener(MouseEvent.MOUSE_DOWN, handleBothDragStart, false, 0 ,true);
						_bothEdges.addEventListener(Event.ENTER_FRAME, handleBothDragMove, false, 0 ,true);
						_bothEdges.addEventListener(MouseEvent.MOUSE_UP, handleDragStop, false, 0 ,true);
						
						addChild(_bothEdges);
					}
					
				} else {
					// horizontalResizable = false
					
					// we check if the events are created and we remove them
					if (_rightEdge.hasEventListener(MouseEvent.MOUSE_OVER))
						_rightEdge.removeEventListener(MouseEvent.MOUSE_OVER, handleHResizeOver);
					if (_rightEdge.hasEventListener(MouseEvent.MOUSE_OUT))
						_rightEdge.removeEventListener(MouseEvent.MOUSE_OUT, handleResizeOut);
					if (_rightEdge.hasEventListener(MouseEvent.MOUSE_DOWN))
						_rightEdge.removeEventListener(MouseEvent.MOUSE_DOWN, handleHDragStart);
					if (_rightEdge.hasEventListener(MouseEvent.MOUSE_UP))
						_rightEdge.removeEventListener(MouseEvent.MOUSE_UP, handleDragStop);
					if (_rightEdge.hasEventListener(Event.ENTER_FRAME))
						_rightEdge.removeEventListener(Event.ENTER_FRAME, handleHDragMove);
					// we remove the events for the right bottom corner (button)	
					if (_bothEdges)
					{
						if (_bothEdges.hasEventListener(MouseEvent.MOUSE_OVER))
							_bothEdges.removeEventListener(MouseEvent.MOUSE_OVER, handleBothResizeOver);
						if (_bothEdges.hasEventListener(MouseEvent.MOUSE_OUT))
							_bothEdges.removeEventListener(MouseEvent.MOUSE_OUT, handleResizeOut);
						if (_bothEdges.hasEventListener(MouseEvent.MOUSE_DOWN))
							_bothEdges.removeEventListener(MouseEvent.MOUSE_DOWN, handleBothDragStart);
						if (_bothEdges.hasEventListener(MouseEvent.MOUSE_UP))
							_bothEdges.removeEventListener(MouseEvent.MOUSE_UP, handleDragStop);
						if (_bothEdges.hasEventListener(Event.ENTER_FRAME))
							_bothEdges.removeEventListener(Event.ENTER_FRAME, handleBothDragMove);
					}
					// we check if the stage if created and if it has the event listener
					if (stage != null && stage.hasEventListener(MouseEvent.MOUSE_UP))
						stage.removeEventListener(MouseEvent.MOUSE_UP, handleDragStop);
					// we remove the edge
					removeChild(_rightEdge);
				}
				// set the resizable value
				// used to see if the value is changed
				_isResizableHorizontally = value;
			}
		}

		// setter to enable/disable the vertical resize functionality
		public function set verticalResizable(value:Boolean):void
		{
			// if the value is changed
			if (value != _isResizableVertically)
			{
				if (value)
				{
					// verticalResizable = true

					// we add the right edge which is a button
					_bottomEdge = new Button();
					// no label
					_bottomEdge.label = "";
					// no tooltip
					_bottomEdge.toolTip = null;
					_bottomEdge.tabEnabled = false;
					_bottomEdge.setStyle("bottom", 0);
					_bottomEdge.setStyle("horizontalCenter",0);
					_bottomEdge.percentWidth = 90;
					_bottomEdge.height = 9;
					// set its style
					// in this style we set the skin to not show anything
					_bottomEdge.styleName = "canvasBottomEdge";
					
					// used to display the resize icon
					_bottomEdge.addEventListener(MouseEvent.MOUSE_OVER, handleVResizeOver, false, 0 ,true);
					// used to display the resize icon
					_bottomEdge.addEventListener(MouseEvent.MOUSE_MOVE, handleVResizeOver, false, 0 ,true);
					// used to hide the resize icon
					_bottomEdge.addEventListener(MouseEvent.MOUSE_OUT, handleResizeOut, false, 0 ,true);
					// used to start the drag
					// we save the initial position and width
					_bottomEdge.addEventListener(MouseEvent.MOUSE_DOWN, handleVDragStart, false, 0 ,true);
					// used for real rezise and other important stuff
					_bottomEdge.addEventListener(Event.ENTER_FRAME, handleVDragMove, false, 0 ,true);
					// used to stop the drag - mouse up on the edge
					_bottomEdge.addEventListener(MouseEvent.MOUSE_UP, handleDragStop, false, 0 ,true);
					
					addChild(_bottomEdge);
					
					// if the right-bottom button is already added
					if (!_bothEdges)
					{
						// we add the right edge which is a button
						_bothEdges = new Button();
						// no label
						_bothEdges.label = "*";
						// no tooltip
						_bothEdges.toolTip = null;
						_bothEdges.tabEnabled = false;
						_bothEdges.setStyle("right", 0);
						_bothEdges.setStyle("bottom",0);
						_bothEdges.height = 15;
						_bothEdges.width = 15;
						// set its style
						// in this style we set the skin to not show anything
						_bothEdges.styleName = "canvasBothEdges";
						
						// if the canvas is only horizontally resizable
						// we use the same events and handlers like in that case
						_bothEdges.addEventListener(MouseEvent.MOUSE_OVER, handleBothResizeOver, false, 0 ,true);
						_bothEdges.addEventListener(MouseEvent.MOUSE_MOVE, handleBothResizeOver, false, 0 ,true);
						_bothEdges.addEventListener(MouseEvent.MOUSE_OUT, handleResizeOut, false, 0 ,true);
						_bothEdges.addEventListener(MouseEvent.MOUSE_DOWN, handleBothDragStart, false, 0 ,true);
						_bothEdges.addEventListener(Event.ENTER_FRAME, handleBothDragMove, false, 0 ,true);
						_bothEdges.addEventListener(MouseEvent.MOUSE_UP, handleDragStop, false, 0 ,true);
						
						addChild(_bothEdges);
					}
					
				} else {
					// verticalResizable = false
					
					// we check if the events are created and we remove them
					if (_bottomEdge.hasEventListener(MouseEvent.MOUSE_OVER))
						_bottomEdge.removeEventListener(MouseEvent.MOUSE_OVER, handleVResizeOver);
					if (_bottomEdge.hasEventListener(MouseEvent.MOUSE_OUT))
						_bottomEdge.removeEventListener(MouseEvent.MOUSE_OUT, handleResizeOut);
					if (_bottomEdge.hasEventListener(MouseEvent.MOUSE_DOWN))
						_bottomEdge.removeEventListener(MouseEvent.MOUSE_DOWN, handleVDragStart);
					if (_bottomEdge.hasEventListener(MouseEvent.MOUSE_UP))
						_bottomEdge.removeEventListener(MouseEvent.MOUSE_UP, handleDragStop);
					if (_bottomEdge.hasEventListener(Event.ENTER_FRAME))
						_bottomEdge.removeEventListener(Event.ENTER_FRAME, handleVDragMove);
					// we remove the events for the right bottom corner (button)	
					if (_bothEdges)
					{
						if (_bothEdges.hasEventListener(MouseEvent.MOUSE_OVER))
							_bothEdges.removeEventListener(MouseEvent.MOUSE_OVER, handleBothResizeOver);
						if (_bothEdges.hasEventListener(MouseEvent.MOUSE_OUT))
							_bothEdges.removeEventListener(MouseEvent.MOUSE_OUT, handleResizeOut);
						if (_bothEdges.hasEventListener(MouseEvent.MOUSE_DOWN))
							_bothEdges.removeEventListener(MouseEvent.MOUSE_DOWN, handleBothDragStart);
						if (_bothEdges.hasEventListener(MouseEvent.MOUSE_UP))
							_bothEdges.removeEventListener(MouseEvent.MOUSE_UP, handleDragStop);
						if (_bothEdges.hasEventListener(Event.ENTER_FRAME))
							_bothEdges.removeEventListener(Event.ENTER_FRAME, handleBothDragMove);
					}
					// we check if the stage if created and if it has the event listener
					if (stage != null && stage.hasEventListener(MouseEvent.MOUSE_UP))
						stage.removeEventListener(MouseEvent.MOUSE_UP, handleDragStop);
					// we remove the edge
					removeChild(_bottomEdge);
				}
				// set the resizable value
				// used to see if the value is changed
				_isResizableVertically = value;
			}
		}

		// event handler to show the resize cursor
		private function handleHResizeOver(event:MouseEvent):void
		{
			_isResizing = true;
			// check if we already have the resize cursor set
			if (_currentCursorId == -1)
				_currentCursorId = CursorManager.setCursor(_hResizeCursor,2,-10);
		}
		
		// event handler to start the drag
		private function handleHDragStart(event:MouseEvent):void
		{
			_dragHStarted = true;
			// we save the initial position and width
			_dragStartHPosition = stage.mouseX;
			_dragLastWidth = width;
		}

		// event handler for real rezise and other important stuff
		private function handleHDragMove(event:Event):void
		{
			// we put the edge always on the top of the other children
			if (getChildIndex(_rightEdge) < numChildren-2)
				setChildIndex(_rightEdge,numChildren-2);
			// we add the event to stop the drag also on the stage
			// we cannot add this event in set resizable because the
			// stage is not created because set resizable is done at
			// constructor time and stage is set after adding our
			// canvas to the application
			if (stage != null && !stage.hasEventListener(MouseEvent.MOUSE_UP))
				stage.addEventListener(MouseEvent.MOUSE_UP, handleDragStop, false, 0 ,true);
			// we resize our canvas only if drag started
			if (_dragHStarted)
			{
				// get the amount of movement
				// difference between the current mouse x position relative 
				// to the stage and the saved position at mouse down event
				var movement:int = (stage.mouseX - _dragStartHPosition);
				// if the canvas is positioned relative to the center
				// the width will be changed in both left and right directions
				// so we will double the movement
				if (getStyle("horizontalCenter") != undefined)
				{
					movement *= 2;
				}
				// if we move to the left
				if (movement <= 0)
				{
					// check not to pass the minimum width
					if (minWidth < _dragLastWidth + movement)
						width = _dragLastWidth + movement;
					else
						width = minWidth;
				} else {
					// check not to pass the maximum width
					if (maxWidth > _dragLastWidth + movement)
						width = _dragLastWidth + movement;
					else
						width = maxWidth;
				}
			}
		}

		// event handler to show the resize cursor
		private function handleVResizeOver(event:MouseEvent):void
		{
			_isResizing = true;
			// check if we already have the resize cursor set
			if (_currentCursorId == -1)
				_currentCursorId = CursorManager.setCursor(_vResizeCursor,2,-10);
		}
		
		// event handler to start the drag
		private function handleVDragStart(event:MouseEvent):void
		{
			_dragVStarted = true;
			// we save the initial position and width
			_dragStartVPosition = stage.mouseY;
			_dragLastHeight = height;
		}

		// event handler for real rezise and other important stuff
		private function handleVDragMove(event:Event):void
		{
			// we put the edge always on the top of the other children 
			// but bellow the right edge
			if (getChildIndex(_bottomEdge) < numChildren-3)
				setChildIndex(_bottomEdge,numChildren-3);
			// we add the event to stop the drag also on the stage
			// we cannot add this event in set resizable because the
			// stage is not created because set resizable is done at
			// constructor time and stage is set after adding our
			// canvas to the application
			if (stage != null && !stage.hasEventListener(MouseEvent.MOUSE_UP))
				stage.addEventListener(MouseEvent.MOUSE_UP, handleDragStop, false, 0 ,true);
			// we resize our canvas only if drag started
			if (_dragVStarted)
			{
				// get the amount of movement
				// difference between the current mouse x position relative 
				// to the stage and the saved position at mouse down event
				var movement:int = (stage.mouseY - _dragStartVPosition);
				// if the canvas is positioned relative to the center
				// the width will be changed in both left and right directions
				// so we will double the movement
				if (getStyle("veticalCenter") != undefined)
				{
					movement *= 2;
				}
				// if we move to the left
				if (movement <= 0)
				{
					// check not to pass the minimum width
					if (minHeight < _dragLastHeight + movement)
						height = _dragLastHeight + movement;
					else
						height = minHeight;
				} else {
					// check not to pass the maximum width
					if (maxHeight > _dragLastHeight + movement)
						height = _dragLastHeight + movement;
					else
						height = maxHeight;
				}
			}
		}
		
		// event handler to show the resize cursor
		private function handleBothResizeOver(event:MouseEvent):void
		{
			//trace ("or is it in here ");
			_isResizing = true;
			// check if we already have the resize cursor set
			if (_currentCursorId == -1)
				_currentCursorId = CursorManager.setCursor(_cResizeCursor,2,-10,-10);
		}
		
		// event handler to start the drag
		private function handleBothDragStart(event:MouseEvent):void
		{
			//trace(" is it here? "+_isResizableHorizontally+"|"+_isResizableVertically);
			_isResizing = true;
			if (_isResizableHorizontally)
			{
				_dragHStarted = true;
				// we save the initial position and width
				_dragStartHPosition = stage.mouseX;
				_dragLastWidth = width;
			}
			if (_isResizableVertically)
			{
				_dragVStarted = true;
				// we save the initial position and width
				_dragStartVPosition = stage.mouseY;
				_dragLastHeight = height;
			}
		}

		// event handler for real rezise and other important stuff
		private function handleBothDragMove(event:Event):void
		{
			// we put the right-bottom always on the top of the other children
			if (getChildIndex(_bothEdges) < numChildren-1)
				setChildIndex(_bothEdges,numChildren-1);
			// we add the event to stop the drag also on the stage
			// we cannot add this event in set resizable because the
			// stage is not created because set resizable is done at
			// constructor time and stage is set after adding our
			// canvas to the application
			if (stage != null && !stage.hasEventListener(MouseEvent.MOUSE_UP))
				stage.addEventListener(MouseEvent.MOUSE_UP, handleDragStop, false, 0 ,true);
			// we resize our canvas only if drag started
			//trace(_dragHStarted+"|"+_dragVStarted);
			if (_dragHStarted)
			{
				// get the amount of movement
				// difference between the current mouse x position relative 
				// to the stage and the saved position at mouse down event
				var hMovement:int = (stage.mouseX - _dragStartHPosition);
				// if the canvas is positioned relative to the center
				// the width will be changed in both left and right directions
				// so we will double the movement
				if (getStyle("horizontalCenter") != undefined)
				{
					hMovement *= 2;
				}
				// if we move to the left
				if (hMovement <= 0)
				{
					// check not to pass the minimum width
					if (minWidth < _dragLastWidth + hMovement)
						width = _dragLastWidth + hMovement;
					else
						width = minWidth;
				} else {
					// check not to pass the maximum width
					if (maxWidth > _dragLastWidth + hMovement)
						width = _dragLastWidth + hMovement;
					else
						width = maxWidth;
				}
			}
			if (_dragVStarted)
			{
				// get the amount of movement
				// difference between the current mouse x position relative 
				// to the stage and the saved position at mouse down event
				var vMovement:int = (stage.mouseY - _dragStartVPosition);
				// if the canvas is positioned relative to the center
				// the width will be changed in both left and right directions
				// so we will double the movement
				if (getStyle("veticalCenter") != undefined)
				{
					vMovement *= 2;
				}
				// if we move to the left
				if (vMovement <= 0)
				{
					// check not to pass the minimum width
					if (minHeight < _dragLastHeight + vMovement)
						height = _dragLastHeight + vMovement;
					else
						height = minHeight;
				} else {
					// check not to pass the maximum width
					if (maxHeight > _dragLastHeight + vMovement)
						height = _dragLastHeight + vMovement;
					else
						height = maxHeight;
				}
			}
		}
		
		// event handler to hide the resize cursor
		private function handleResizeOut(event:MouseEvent):void
		{
			_isResizing = false;
			if (!_dragHStarted && !_dragVStarted) {
				CursorManager.removeCursor(_currentCursorId);
				_currentCursorId = -1;
			}
		}
		
		// event handler to stop the drag
		private function handleDragStop(event:MouseEvent):void
		{
			trace ( "@@ handleDragStop in ResizableCanvas");
			_dragHStarted = false;
			_dragVStarted = false;
			_isResizing = false;
			CursorManager.removeCursor(_currentCursorId);
			_currentCursorId = -1;
			
		}
		private function handleKeyDown( event:KeyboardEvent):void
		{
			if( event.keyCode == Keyboard.ESCAPE ){
				trace("@@handleKeyDown in Resizable Canvas| ESC Key handled")
				if( _dragHStarted ) {
					trace (" H Drag stopped ");
					_rightEdge.dispatchEvent( new MouseEvent( MouseEvent.MOUSE_UP, true, false ) );
				}
				else if ( _dragVStarted ) {
					trace (" V Drag stopped ");
					_bottomEdge.dispatchEvent( new MouseEvent( MouseEvent.MOUSE_UP, true, false ) );
				}
				else if ( _dragHStarted && _dragVStarted ) {
					trace (" Both Drags stopped ");
					_bothEdges.dispatchEvent( new MouseEvent( MouseEvent.MOUSE_UP, true, false ) );
				}
				else {
					trace ( "Nowhere to dispatch" );
				}
			}
		}
		// public function for triggering the handleDragStop funtion
		public function remoteStopDrag():void
		{
			trace( "@@ remoteDragStop in ResizableCanvas" );
			var eventDispatcher : EventDispatcher = new EventDispatcher();
			eventDispatcher.dispatchEvent( new MouseEvent( MouseEvent.MOUSE_UP, true, false));
		}
		// function to check is the canvas is resizing
		public function resizing ():Boolean
		{
			//trace ("function called isResizing = " + _isResizing);
			if ( _isResizing )
			{
				return true;
				
			} else return false;
		}

	}
}