package mo.cr.ui
{
   import mo.cr.ui.control.EUiControlType;
   import mo.cr.ui.control.FUiAnimationMovie;
   import mo.cr.ui.control.FUiButton;
   import mo.cr.ui.control.FUiCheck;
   import mo.cr.ui.control.FUiDrag;
   import mo.cr.ui.control.FUiEdit;
   import mo.cr.ui.control.FUiGrid;
   import mo.cr.ui.control.FUiLabel;
   import mo.cr.ui.control.FUiListBox;
   import mo.cr.ui.control.FUiLoaderPictrueBox;
   import mo.cr.ui.control.FUiPage;
   import mo.cr.ui.control.FUiPageControl;
   import mo.cr.ui.control.FUiPanel;
   import mo.cr.ui.control.FUiPictureBox;
   import mo.cr.ui.control.FUiProgressBar;
   import mo.cr.ui.control.FUiRadio;
   import mo.cr.ui.control.FUiSPanel;
   import mo.cr.ui.control.FUiSelect;
   import mo.cr.ui.control.FUiSlot;
   import mo.cr.ui.control.FUiTable;
   import mo.cr.ui.control.FUiTreeView;
   import mo.cr.ui.form.FUiBar;
   import mo.cr.ui.form.FUiForm;
   import mo.cr.ui.form.FUiWindow;
   import mo.cr.ui.layout.FUiBorder;
   import mo.cr.ui.layout.FUiScrollBox;

   //============================================================
   // <T>UI工厂</T>
   //
   // @author HECNG 20120330
   //============================================================
   public class FUiFactory
   {
      // 组件库
      public var controls:Vector.<FUiControl3d> = new Vector.<FUiControl3d>();
      
      //============================================================
      // <T>构造函数</T>
      //
      // @author HECNG 20120330
      //============================================================
      public function FUiFactory(){
      }
      
      //============================================================
      // <T>移除某个组件</T>
      //
      // @author HECNG 20120330
      //============================================================
      public function removeControl(f:FUiControl3d):void{
         var i:int = controls.indexOf(f);
         if(i != -1){
            controls.splice(i, 1);
         }
      }
      
      //============================================================
      // <T>创建组件</T>
      //
      // @params p:name 组件名称
      // @author HECNG 20120330
      //============================================================
      public function create(p:String):*{
         var control:FUiControl3d;
         switch(p){
            case EUiControlType.Drag:
               control = new FUiDrag();
               break;
            case EUiControlType.Bar:
               control = new FUiBar();
               break;
            case EUiControlType.Button:
               control = new FUiButton();
               break;
            case EUiControlType.Check:
               control = new FUiCheck();
               break;
            case EUiControlType.Edit:
               control = new FUiEdit();
               break;
            case EUiControlType.Form:
               control = new FUiForm();
               break;
            case EUiControlType.Grid:
               control = new FUiGrid();
               break;
            case EUiControlType.ListBox:
               control = new FUiListBox();
               break;      
            case EUiControlType.PageControl:
               control = new FUiPageControl();
               break;
            case EUiControlType.Radio:
               control = new FUiRadio();
               break;
            case EUiControlType.Select:
               control = new FUiSelect();
               break;
            case EUiControlType.Slot:
               control = new FUiSlot();
               break;
            case EUiControlType.TreeView:
               control = new FUiTreeView();
               break;
            case EUiControlType.Window:
               control = new FUiWindow();
               break;
			   case EUiControlType.Page:
				   control = new FUiPage();
				   break;
            case EUiControlType.PictureBox:
               control = new FUiPictureBox();
               break;
            case EUiControlType.ProgressBar:
               control = new FUiProgressBar();
               break;
            case EUiControlType.Panel:
               control = new FUiPanel();
               break;
            case EUiControlType.Label:
               control = new FUiLabel();
               break;
            case EUiControlType.Table:
               control = new FUiTable();
               break;
            case EUiControlType.SPanel:
               control = new FUiSPanel();
               break;
            case EUiControlType.LoaderPictureBox:
               control = new FUiLoaderPictrueBox();
               break;
            case EUiControlType.AnimationMovie:
               control = new FUiAnimationMovie();
               break;
         }
         if(control){
            controls.push(control);
         }
         return control;
      }
   }
}