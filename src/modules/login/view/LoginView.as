/**
 * Created by abrashkin on 29.10.2014.
 */
package modules.login.view {
import flash.events.MouseEvent;

import modules.login.view.ui.LoginBaseView;

public class LoginView extends LoginBaseView {

    public function LoginView() {
        initListeners();
    }

    private function initListeners():void {
        this.buttonCancel.addEventListener( MouseEvent.CLICK, handlerClickCancel );
    }

    private function handlerClickCancel(event:MouseEvent):void {
        navigator.popView()
    }

}
}
