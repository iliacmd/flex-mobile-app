/**
 * Created by abrashkin on 29.10.2014.
 */
package modules.home.view {
import components.Preloader;

import flash.events.Event;
import flash.net.URLLoader;
import flash.net.URLRequest;

import modules.home.view.ui.HomeBaseView;
import modules.search.view.ui.DetailBaseView;

import mx.binding.utils.BindingUtils;
import mx.collections.ArrayCollection;
import mx.events.FlexEvent;
import mx.managers.PopUpManager;

import spark.components.BusyIndicator;
import spark.events.IndexChangeEvent;

public class HomeView extends HomeBaseView {

    private var preLoader:BusyIndicator;

    public function HomeView() {
        addEventListener( FlexEvent.CREATION_COMPLETE, init );
    }

    private function showDetail(item:Object):void {
        navigator.pushView(DetailBaseView, item);
    }

    private function init( event:Event ):void {
        filterBar.addEventListener( IndexChangeEvent.CHANGE, filterBar_changeHandler );
        list.addEventListener( IndexChangeEvent.CHANGE, list_changeHandler );
        preLoader = new Preloader();
        loadRecommended();
    }

    private function list_changeHandler():void {
        showDetail(list.selectedItem);
    }

    private function filterBar_changeHandler(event:IndexChangeEvent):void {
        switch( event.newIndex ){
            case 0:
                this.loadRecommended();
            break;
            case 1:
                this.loadBest();
            break;
            case 2:
            default:
                this.loadNew();
        }

    }

    private function loadRecommended():void {

        var loader:URLLoader = new URLLoader( new URLRequest("data/recommend.json") );
        loader.addEventListener(Event.COMPLETE, handlerCompleteLoadData);
        PopUpManager.addPopUp(preLoader, this);
        PopUpManager.centerPopUp(preLoader);
        list.visible = false;

    }

    private function loadBest():void {

        var loader:URLLoader = new URLLoader( new URLRequest("data/best.json") );
        loader.addEventListener(Event.COMPLETE, handlerCompleteLoadData);
        PopUpManager.addPopUp(preLoader, this);
        PopUpManager.centerPopUp(preLoader);
        list.visible = false;

    }

    private function loadNew():void {

        var loader:URLLoader = new URLLoader( new URLRequest("data/new.json") );
        loader.addEventListener(Event.COMPLETE, handlerCompleteLoadData);
        PopUpManager.addPopUp(preLoader, this);
        PopUpManager.centerPopUp(preLoader);
        list.visible = false;

    }


    private function handlerCompleteLoadData(event:Event):void {
        var data:Array = JSON.parse(event.target.data) as Array;
        this.items = new ArrayCollection(data);
        PopUpManager.removePopUp(preLoader);
        list.visible = true;
    }

}
}
