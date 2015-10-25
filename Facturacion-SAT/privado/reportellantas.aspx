<%@ Page Language="VB" AutoEventWireup="false" CodeFile="reportellantas.aspx.vb" Inherits="privado_reportellantas" %>

<%@ Register Assembly="System.Web, Version=1.0.5000.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a" Namespace="System.Web.UI.WebControls" TagPrefix="asp" %>

<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0">
  <meta name="description" content="">
  <meta name="author" content="">
  <link rel="shortcut icon" href="images/favicon.png" type="image/png">

  <title>Envio de Liquidacion | <%=datos.addKey("NameProject")%></title>

  <link rel="stylesheet" href="css/style.default.css" />
  
  <link rel="stylesheet" href="css/bootstrap-fileupload.min.css" />
  <link rel="stylesheet" href="css/bootstrap-timepicker.min.css" />
  <link rel="stylesheet" href="css/jquery.tagsinput.css" />
  <link rel="stylesheet" href="css/colorpicker.css" />
  <link rel="stylesheet" href="css/dropzone.css" />
  <link rel="stylesheet" href="css/autocomplete.css" />
  <link rel="Stylesheet" href="css/jquery-ui.css"
  <link href="css/style.default.css" rel="stylesheet">
  <link href="css/jquery.gritter.css" rel="stylesheet">
  <link rel="stylesheet" href="css/colorpicker.css" />
  <style>.grids th{text-align:center}</style>

  <!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
  <!--[if lt IE 9]>
  <script src="js/html5shiv.js"></script>
  <script src="js/respond.min.js"></script>
  <![endif]-->
  
</head>

<body>

<!-- Preloader -->
<div id="preloader">
    <div id="status"><i class="fa fa-spinner fa-spin"></i></div>
</div>

<section>
  
  <div class="leftpanel">
    
    <div class="logopanel">
        <h1><span>[</span> <%=datos.addKey("NameProject")%> <span>]</span></h1>
    </div><!-- logopanel -->
    
    <div class="leftpanelinner">
        
        <!-- This is only visible to small devices -->
        <!-- #include file="usuario.html"-->
      
      <h5 class="sidebartitle">Men&uacute;</h5>
      <!--#include file="menu.html" -->
    </div><!-- leftpanelinner -->
  </div><!-- leftpanel -->
  
  <div class="mainpanel">
    
    <div class="headerbar">
      <a class="menutoggle"><i class="fa fa-bars"></i></a>
      <!-- #INCLUDE FILE="usuariomenu.html" --> 
    </div><!-- headerbar -->
    
    <div class="pageheader">
      <h2><i class="fa fa-edit"></i> Llantas Por Vehiculo <span>Reporte...</span></h2>
    </div>
    
    
      <form class="form-horizontal form-bordered" runat="server" id="formulario">
     
        <div class="panel-body panel-body-nopadding">
          
            <div class="panel panel-default">
            <div class="form-group">
              <label class="col-sm-2 control-label">Flota</label>
              <div class="col-sm-4">
             <asp:DropDownList ID="DropDepartamentos" runat="server" CssClass="form-control">
                        </asp:DropDownList>
                        </div>
              <div class="col-sm-6">
             
                    <div class="input-group">
                        <div class="col-sm-6">

                      <input type="button" value="Actualizar" id="BtnActualizar" class="btn btn-primary" />
                    </div>
                  <%--      <div class="col-sm-6">
                        <button type="button" class="btn btn-info" value="Resumen" id="BtnResumen" >Resumen</button>
                    </div>--%>
                </div>
                  
             
                          
                           

             
           </div>
           </div>
           </div>
           
           
           

                <div class="panel panel-default">
           
                        <div class="form-legend" id="Input_Field">Ingreso de datos</div>
					<div class="form-group">
                  
                          
                            	<label class="col-sm-2 control-label" for="label" >
                                    Llantas En Buen Estado
                                </label>
                                <label class="col-sm-1 control-label" for="label" id="LblBuenEstado" style="font-size:1.8em; color:#32a717; font-weight:bold; text-shadow: 0.1em 0.1em 0.05em #333;"></label>
                     
                           
                            	<label class="col-sm-2 control-label" for="label" >
                                    En Estado Regular
                                </label>
                                <label class="col-sm-1 control-label" for="label" id="LblEstadoRegular" style="font-size:1.8em; color:#ffa800; font-weight:bold; text-shadow: 0.1em 0.1em 0.05em #333;"></label>
                          
                            	<label class="col-sm-2 control-label" for="label" >
                                    En Mal Estado
                                </label>
                        
                                <label class="col-sm-1 control-label" for="label" id="LblMalEstado" style="font-size:1.8em; color:#ff0000; font-weight:bold; text-shadow: 0.1em 0.1em 0.05em #333;"></label>
                           
                             
                            	<label class="col-sm-2 control-label" for="label" >
                                    Rechazadas
                                </label>

                                <label class="col-sm-1 control-label" for="label" id="LblRechazadas" style="font-size:1.8em; color:#2588e5; font-weight:bold; text-shadow: 0.1em 0.1em 0.05em #333;"></label>
                            
                </div>
                     
                        
                        </div>
 
        <div class="row">
        <div class="col-md-12">
          <div class="table-responsive">
          <div>
          <table class="table table-bordered table-striped reporteLlantas">
                                       <thead>
                                           <tr>
                                               <th>Vehiculo</th>
                                               <th>Lla 01</th>
                                               <th>Lla 02</th>
                                               <th>Lla 03</th>
                                               <th>Lla 04</th>
                                               <th>Lla 05</th>
                                               <th>Lla 06</th>
                                               <th>Lla 07</th>
                                               <th>Lla 08</th>
                                               <th>Lla 09</th>
                                               <th>Lla 10</th>
                                               <th>Lla 11</th>
                                               <th>Lla 12</th>
                                               <th>Lla 13</th>
                                               <th>Lla 14</th>
                                               <th>Lla 15</th>
                                               <th>Lla 16</th>
                                               <th>Lla 17</th>
                                               <th>Lla 18</th>
                                               <th>Lla 19</th>
                                               <th>RE 01</th>
                                               <th>RE 02</th>
                                           </tr>
                                       </thead>
                                       
                                   </table>
					
                               </div>
             
             
              
              
                
       
                <ul class="nav nav-pills nav-justified">
                  <li><a href="#tab4" data-toggle="tab" type ="hidden"><span id="destino">Resumen:</span></a></li>
                </ul>
                <div class="tab-content">
                      <div class="col-sm-12">
                         <div id="chartdiv1" style="width: 100%; height: 150px;"></div>
        
                         </div>
                    <div class="form-group">
                      
                    <div class="col-sm-12" id="chartdiv" style="width: 100%; height: 452px;"></div>
       
                            
                
                        </div>     
                     </div> 
                 
                  <div class="tab-content">
                      <div class="form-group">
                        <div class="col-sm-12"  id="PieSubRendimiento" style="width:100%; height:380px; display:none;"></div>
                    <div class="table-responsive" style="display:none;" id="DivDet">
                       </div>
                  </div> 
              </div>       
             
        
             </div>        
                         
                    </div>
                 
                </div><!-- tab-content -->
                <%--<ul class="pager wizard">
                    <li class="previous"><a href="javascript:void(0)">Previous</a></li>
                    <li class="next"><a href="javascript:void(0)">Next</a></li>
                  </ul>--%>
              </div><!-- #basicWizard -->
            </div><!-- panel-body -->
    <div class="modal fade ModalEditarVehiculo" tabindex="-1" role="dialog" aria-labelledby="mySmallModalLabel" data-backdrop="static" aria-hidden="true">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
        <div class="modal-header">
            <button aria-hidden="true" data-dismiss="modal" class="close" type="button">&times;</button>
            <h4 class="modal-title"><span style="display:none" id="LblModificar">Modificaion</span><span style="display:none" id="LblCrear">Creacion</span> LLantas : <i><label id="LblCodigo"></label></i></h4>
        </div>
        <div class="modal-body">
        <input type="hidden" id="Hidden1" />
            <div class="form-group">
            <asp:Label ID="Label2" runat="server" Text="Fecha de Intalacion: "></asp:Label>
            <asp:Label ID="LblFecha" runat="server" Text=""></asp:Label>
                 </div>
                 <div class="form-group">
            <asp:Label ID="Label3" runat="server" Text="Kilometraje: "></asp:Label>
            <asp:Label ID="LblKilometraje" runat="server" Text=""></asp:Label>
                 </div>
            <div class="form-group">
                <div class="col-sm-3">
            <asp:Label ID="Label1" runat="server" Text="32avos Actuales: "></asp:Label>
                     </div>
                 <div class="col-sm-2">
            <asp:Label ID="LblDesgaste" runat="server" Text=""></asp:Label>
                     </div>
                    <div class="col-sm-3">
            <asp:Label ID="Label6" runat="server" Text="32avos Desgastados: "></asp:Label>
                     </div>
                 <div class="col-sm-2">
            <asp:Label ID="LblDesgasteAnt" runat="server" Text=""></asp:Label>
                     </div>
                     </div>
            
       
            <div class="form-group">
                <div class="col-sm-3">
            <asp:Label ID="Label4" runat="server" Text="Costro por Kilometro: "></asp:Label>
                    </div>
                    <div class="col-sm-2">
            <asp:Label ID="Lblrenkp" runat="server" Text="Label"></asp:Label>
                        </div>

                      <div class="col-sm-3">
            <asp:Label ID="Label5" runat="server" Text="Rendimiento por 32 avo: "></asp:Label>
                    </div>
                    <div class="col-sm-2">
            <asp:Label ID="LblRenXTreinta" runat="server" Text="Label"></asp:Label>
                        </div>
                <div class="col-sm-2">
            
                        </div>
                 </div>
            
            <table class="table table-bordered table-striped TablaMovimientosll">
    <thead>
    	<tr>
        	<th>Vehiculo</th>
            <th>Movimiento</th>
            <th>Km Actual</th>
            <th>Fecha</th>
            <th>Motivo</th>
            <th>Encargado</th>
            <th>Observaciones</th>
        </tr>
    </thead>
           </table>
  </div>
</div>



            </div>
           
				  <br/>
                </div>
            
           
<%--            </form>--%>
          
          
<%--          <form class="form-horizontal form-bordered">--%>
 
                    
            </form>
            
          </div><!-- table-responsive -->
        <%--</div>--%><!-- col-md-12 -->
      <%--</div>--%><!-- row -->
    </div><!-- contentpanel -->
  <%--</div>--%><!-- mainpanel -->
</section>
<script src="js/jquery-1.10.2.min.js"></script>
<script src="js/jquery-migrate-1.2.1.min.js"></script>
<script src="js/bootstrap.min.js"></script>
<script src="js/modernizr.min.js"></script>
<script src="js/jquery.sparkline.min.js"></script>
<script src="js/toggles.min.js"></script>
<script src="js/retina.min.js"></script>
<script src="js/jquery.cookies.js"></script>
<script type="text/javascript" src="http://www.amcharts.com/lib/3/amcharts.js"></script>
<script type="text/javascript" src="http://www.amcharts.com/lib/3/pie.js"></script>
<script type="text/javascript" src="http://www.amcharts.com/lib/3/themes/none.js"></script>
<script src="js/amCharts/amcharts.js" type="text/javascript"></script>
<script src="js/amCharts/pie.js" type="text/javascript"></script>
    <script src="js/amcharts/pie.js" type="text/javascript"></script>
<script src="js/amCharts/serial.js" type="text/javascript"></script>
<script src="js/bootstrap-wizard.min.js"></script>
<script src="js/jquery.validate.min.js"></script>
<script src="js/chosen.jquery.min.js"></script>
<script src="js/custom.js"></script>
<script src="js/jquery.gritter.min.js"></script>
<%--<script src="js/select2.min.js"></script>--%>
<script src="js/jquery-ui-1.10.3.min.js"></script>
<script src="js/jquery.datatables.min.js"></script>
<script src="js/dataTables.tableTools.js"></script>
<script src="js/jquery.fancybox.js"></script>
<script src="js/highcharts.js"></script>
<script src="js/modules/data.js"></script>
<script src="js/modules/drilldown.js"></script>
<script type="text/javascript">
    $(document).ready(function () {
        $(".reporteLlantas").dataTable({
            aLengthMenu: [
    [25, 50, 100, 200, -1],
    [25, 50, 100, 200, "All"]
            ],
            iDisplayLength: -1
        });


        $("#BtnActualizar").click(function () {
            $(".reporteLlantas").dataTable().fnClearTable();
            MostrarVehiculos(0)
        });
        $("#BtnResumen").click(function () {
            ReporteTotalLLantas()

            ReporteEstadoLLantas()
            $("html,body").animate({ scrollTop: $("#destino").offset().top }, 1500);
        });

        MostrarVehiculos(0)



    }); //fin document.ready




    function MostrarVehiculos(id) {

        $.ajax({
            type: "POST",
            url: "WebService.asmx/ReporteLlantas",
            data: "{Departamento: " + $("#DropDepartamentos").val() + "}",
            dataType: 'json',
            contentType: "application/json; charset=utf-8",
            success: function (data) {
                $(".reporteLlantas").hide();
                console.log($("#DropDepartamentos").val());
                $.each(data.d, function (index, item) {

                    var clase = "";
                    if (item.desgaste1 > 7) {
                        clase = "btn-success"
                    } else if (item.desgaste1 > 4 && item.desgaste1 <= 8) {
                        clase = "btn-warning"
                    } else {
                        clase = "btn-danger"
                    } if (item.llantad1 <= '0') {
                        var td1 = "";
                    } else if (item.llantad2 != '0') {
                        var td1 = "<button type='button' id='" + item.llantad1 + "' class='btn " + clase + " BtnLlanta 'aria-label='center Align'>" + ajustar(1, item.desgaste1) + "</button>";
                    }





                    var clase = "";
                    if (item.desgaste2 > 7) {
                        clase = "btn-success"
                    } else if (item.desgaste2 > 4 && item.desgaste2 <= 8) {
                        clase = "btn-warning"
                    } else {
                        clase = "btn-danger"
                    } if (item.llantad2 <= '0') {
                        var td2 = "";
                    } else if (item.llantad2 != '0') {
                        var td2 = "<button type='button' id='" + item.llantad2 + "' class='btn " + clase + " BtnLlanta 'aria-label='center Align'>" + ajustar(1, item.desgaste2) + "</button>";
                    }





                    var clase = "";
                    if (item.desgaste3 > 7) {
                        clase = "btn-success"
                    } else if (item.desgaste3 > 4 && item.desgaste3 <= 8) {
                        clase = "btn-warning"
                    } else {
                        clase = "btn-danger"
                    } if (item.llantad3 <= '0') {
                        var td3 = "";
                    } else if (item.llantad3 != '0') {
                        var td3 = "<button type='button' id='" + item.llantad3 + "' class='btn " + clase + " BtnLlanta 'aria-label='center Align'>" + ajustar(1, item.desgaste3) + "</button>";
                    }






                    var clase = "";
                    if (item.desgaste4 > 7) {
                        clase = "btn-success"
                    } else if (item.desgaste4 > 4 && item.desgaste4 <= 8) {
                        clase = "btn-warning"
                    }
                    else {
                        clase = "btn-danger"
                    } if (item.llantad4 <= '0') {
                        var td4 = "";
                    } else if (item.llantad4 != '0') {
                        var td4 = "<button type='button' id='" + item.llantad4 + "' class='btn " + clase + " BtnLlanta 'aria-label='center Align'>" + ajustar(1, item.desgaste4) + "</button>";
                    }






                    var clase = "";
                    if (item.desgaste5 > 7) {
                        clase = "btn-success"
                    } else if (item.desgaste5 > 4 && item.desgaste5 <= 8) {
                        clase = "btn-warning"
                    }

                    else {
                        clase = "btn-danger"
                    }
                    if (item.llantad5 <= '0') {
                        var td5 = "";
                    } else if (item.llantad5 != '0') {
                        var td5 = "<button type='button' id='" + item.llantad5 + "' class='btn " + clase + " BtnLlanta 'aria-label='center Align'>" + ajustar(1, item.desgaste5) + "</button>";
                    }

                    var clase = "";
                    if (item.desgaste6 > 7) {
                        clase = "btn-success"
                    } else if (item.desgaste6 > 4 && item.desgaste6 <= 8) {
                        clase = "btn-warning"
                    } else {
                        clase = "btn-danger"
                    } if (item.llantad6 <= '0') {
                        var td6 = "";
                    } else if (item.llantad6 != '0') {
                        var td6 = "<button type='button' id='" + item.llantad6 + "' class='btn " + clase + " BtnLlanta 'aria-label='center Align'>" + ajustar(1, item.desgaste6) + "</button>";
                    }


                    var clase = "";
                    if (item.desgaste7 > 7) {
                        clase = "btn-success"
                    } else if (item.desgaste7 > 4 && item.desgaste7 <= 8) {
                        clase = "btn-warning"
                    } else {
                        clase = "btn-danger"
                    } if (item.llantad7 <= '0') {
                        var td7 = "";
                    } else if (item.llantad7 != '0') {
                        var td7 = "<button type='button' id='" + item.llantad7 + "' class='btn " + clase + " BtnLlanta 'aria-label='center Align'>" + ajustar(1, item.desgaste7) + "</button>";
                    }



                    var clase = "";
                    if (item.desgaste8 > 7) {
                        clase = "btn-success"
                    } else if (item.desgaste8 > 4 && item.desgaste8 <= 8) {
                        clase = "btn-warning"
                    } else {
                        clase = "btn-danger"
                    } if (item.llantad8 <= '0') {
                        var td8 = "";
                    } else if (item.llantad8 != '0') {
                        var td8 = "<button type='button' id='" + item.llantad8 + "' class='btn " + clase + " BtnLlanta 'aria-label='center Align'>" + ajustar(1, item.desgaste8) + "</button>";
                    }



                    var clase = "";
                    if (item.desgaste9 > 7) {
                        clase = "btn-success"
                    } else if (item.desgaste9 > 4 && item.desgaste9 <= 8) {
                        clase = "btn-warning"
                    } else {
                        clase = "btn-danger"
                    }
                    if (item.llantad9 <= '0') {
                        var td9 = "";
                    } else if (item.llantad9 != '0') {
                        var td9 = "<button type='button' id='" + item.llantad9 + "' class='btn " + clase + " BtnLlanta 'aria-label='center Align'>" + ajustar(1, item.desgaste9) + "</button>";
                    }

                    var clase = "";
                    if (item.desgaste10 > 7) {
                        clase = "btn-success"
                    } else if (item.desgaste10 > 4 && item.desgaste10 <= 8) {
                        clase = "btn-warning"
                    } else {
                        clase = "btn-danger"
                    } if (item.llantad10 <= '0') {
                        var td10 = "";
                    } else if (item.llantad10 != '0') {
                        var td10 = "<button type='button' id='" + item.llantad10 + "' class='btn " + clase + " BtnLlanta 'aria-label='center Align'>" + ajustar(1, item.desgaste10) + "</button>";
                    }
                    var clase = "";
                    if (item.desgaste11 > 7) {
                        clase = "btn-success"
                    } else if (item.desgaste11 > 4 && item.desgaste11 <= 8) {
                        clase = "btn-warning"
                    }
                    else {
                        clase = "btn-danger"
                    }
                    if (item.llantad11 <= '0') {
                        var td11 = "";
                    } else if (item.llantad11 != '0') {
                        var td11 = "<button type='button' id='" + item.llantad11 + "' class='btn " + clase + " BtnLlanta 'aria-label='center Align'>" + ajustar(1, item.desgaste11) + "</button>";
                    }

                    var clase = "";
                    if (item.desgaste12 > 7) {
                        clase = "btn-success"
                    } else if (item.desgaste12 > 4 && item.desgaste12 <= 8) {
                        clase = "btn-warning"
                    } else {
                        clase = "btn-danger"
                    }
                    if (item.llantad12 <= '0') {
                        var td12 = "";
                    } else if (item.llantad12 != '0') {
                        var td12 = "<button type='button' id='" + item.llantad12 + "' class='btn " + clase + " BtnLlanta 'aria-label='center Align'>" + ajustar(1, item.desgaste12) + "</button>";
                    }

                    var clase = "";
                    if (item.desgaste13 > 7) {
                        clase = "btn-success"
                    } else if (item.desgaste13 > 4 && item.desgaste13 <= 8) {
                        clase = "btn-warning"
                    } else {
                        clase = "btn-danger"
                    }
                    if (item.llantad13 <= '0') {
                        var td13 = "";
                    } else if (item.llantad13 != '0') {
                        var td13 = "<button type='button' id='" + item.llantad13 + "' class='btn " + clase + " BtnLlanta 'aria-label='center Align'>" + ajustar(1, item.desgaste13) + "</button>";
                    }


                    var clase = "";
                    if (item.desgaste14 > 7) {
                        clase = "btn-success"
                    } else if (item.desgaste14 > 4 && item.desgaste14 <= 8) {
                        clase = "btn-warning"
                    } else {
                        clase = "btn-danger"
                    } if (item.llantad14 <= '0') {
                        var td14 = "";
                    } else if (item.llantad14 != '0') {
                        var td14 = "<button type='button' id='" + item.llantad14 + "' class='btn " + clase + " BtnLlanta 'aria-label='center Align'>" + ajustar(1, item.desgaste14) + "</button>";
                    }


                    var clase = "";
                    if (item.desgaste15 > 7) {
                        clase = "btn-success"
                    } else if (item.desgaste15 > 4 && item.desgaste15 <= 8) {
                        clase = "btn-warning"
                    } else {
                        clase = "btn-danger"
                    } if (item.llantad15 <= '0') {
                        var td15 = "";
                    } else if (item.llantad15 != '0') {
                        var td15 = "<button type='button' id='" + item.llantad15 + "' class='btn " + clase + " BtnLlanta 'aria-label='center Align'>" + ajustar(1, item.desgaste15) + "</button>";
                    }


                    var clase = "";
                    if (item.desgaste16 > 7) {
                        clase = "btn-success"
                    } else if (item.desgaste16 > 4 && item.desgaste16 <= 8) {
                        clase = "btn-warning"
                    } else {
                        clase = "btn-danger"
                    } if (item.llantad16 <= '0') {
                        var td16 = "";
                    } else if (item.llantad16 != '0') {
                        var td16 = "<button type='button' id='" + item.llantad16 + "' class='btn " + clase + " BtnLlanta 'aria-label='center Align'>" + ajustar(1, item.desgaste16) + "</button>";
                    }


                    var clase = "";
                    if (item.desgaste17 > 7) {
                        clase = "btn-success"
                    } else if (item.desgaste17 > 4 && item.desgaste17 <= 8) {
                        clase = "btn-warning"
                    } else {
                        clase = "btn-danger"
                    } if (item.llantad17 <= '0') {
                        var td17 = "";
                    } else if (item.llantad17 != '0') {
                        var td17 = "<button type='button' id='" + item.llantad17 + "' class='btn " + clase + " BtnLlanta 'aria-label='center Align'>" + ajustar(1, item.desgaste17) + "</button>";
                    }


                    var clase = "";
                    if (item.desgaste18 > 7) {
                        clase = "btn-success"
                    } else if (item.desgaste18 > 4 && item.desgaste18 <= 8) {
                        clase = "btn-warning"
                    } else {
                        clase = "btn-danger"
                    } if (item.llantad18 <= '0') {
                        var td18 = "";
                    } else if (item.llantad18 != '0') {
                        var td18 = "<button type='button' id='" + item.llantad18 + "' class='btn " + clase + " BtnLlanta 'aria-label='center Align'>" + ajustar(1, item.desgaste18) + "</button>";
                    }


                    var clase = "";
                    if (item.desgaste19 > 7) {
                        clase = "btn-success"
                    } else if (item.desgaste19 > 4 && item.desgaste19 <= 8) {
                        clase = "btn-warning"
                    } else {
                        clase = "btn-danger"
                    } if (item.llantad19 <= '0') {
                        var td19 = "";
                    } else if (item.llantad19 != '0') {
                        var td19 = "<button type='button' id='" + item.llantad19 + "' class='btn " + clase + " BtnLlanta 'aria-label='center Align'>" + ajustar(1, item.desgaste19) + "</button>";
                    }

                    var clase = "";
                    if (item.desgaster1 > 7) {
                        clase = "btn-success"
                    } else if (item.desgaster1 > 4 && item.desgaster1 <= 8) {
                        clase = "btn-warning"
                    }
                    else {
                        clase = "btn-danger"
                    } if (item.repuestod1 <= '0') {
                        var tdr1 = "";
                    } else if (item.repuestod1 != '0') {
                        var tdr1 = "<button type='button' id='" + item.repuestod1 + "' class='btn " + clase + " BtnLlanta 'aria-label='center Align'>" + ajustar(1, item.desgaster1) + "</button>";
                    }



                    var clase = "";
                    if (item.desgaster2 > 7) {
                        clase = "btn-success"
                    } else if (item.desgaster2 > 4 && item.desgaster2 <= 8) {
                        clase = "btn-warning"
                    }
                    else {
                        clase = "btn-danger"
                    } if (item.repuestod2 <= '0') {
                        var tdr2 = "";
                    } else if (item.repuestod2 != '0') {
                        var tdr2 = "<button type='button' id='" + item.repuestod2 + "' class='btn " + clase + " BtnLlanta 'aria-label='center Align'>" + ajustar(1, item.desgaster2) + "</button>";
                    }
                    $(".reporteLlantas").dataTable().fnAddData([
                item.Vehiculo,
                td1,
                td2,
                td3,
                td4,
                td5,
                td6,
                td7,
                td8,
                td9,
                td10,
                td11,
                td12,
                td13,
                td14,
                td15,
                td16,
                td17,
                td18,
                td19,
                tdr1,
                tdr2

                    //"<button type='button' id='" + item.Id + "' class='btn btn-default btn-xs BtnEditarVehiculo'  aria-label='Left Align'><i class='glyphicon glyphicon-edit EditarVehiculo'></i> Editar</button>"
                    // "<class='" + item.llanta1 + " btn-danger'>0</td><td class='" + item.llanta2 + " btn-danger'>0</td><td class='" + item.llanta3 + " btn-danger'>0</td><td class='" + item.llanta4 + " btn-danger'>0</td><td class='" + item.llanta5 + " btn-danger'>0</td><td class='" + item.llanta6 + " btn-danger'>0</td><td class='" + item.llanta7 + " btn-danger'>0</td><td class='" + item.llanta8 + " btn-danger'>0</td><td class='" + item.llanta9 + " btn-danger'>0</td><td class='" + item.llanta10 + " btn-danger'>0</td><td class='" + item.llanta11 + " btn-danger'>0</td><td class='" + item.llanta12 + " btn-danger'>0</td><td class='" + item.llanta13 + " btn-danger'>0</td><td class='" + item.llanta14 + " btn-danger'>0</td><td class='" + item.llanta15 + " btn-danger'>0</td><td class='" + item.llanta16 + " btn-danger'>0</td><td class='" + item.llanta17 + " btn-danger'>0</td><td class='" + item.llanta18 + " btn-danger'>0</td><td class='" + item.llanta19 + " btn-danger'>0</td><td class='" + item.llanta20 + " btn-danger'>0</td><td class='" + item.repuesto1 + " btn-danger'>0</td><td class='" + item.repuesto2 + " btn-danger'>0</td></tr>");
                    ]);
                });
                $(".reporteLlantas").show();
                $("#LblBuenEstado").html(($(".btn-success").size()));
                $("#LblEstadoRegular").html($(".btn-warning").size());
                $("#LblMalEstado").html(($(".btn-danger").size()));
                $("#LblRechazadas").html(($(".btn btn-default").size()));
            },
            error: function (data) {
                console.log(data);
            }
        });

    }



    $(document).ready(function () {

        $(".reporteLlantas tbody").on("click", ".BtnLlanta", function () {
            var id = this.id;

            $('.ModalEditarVehiculo').modal('toggle');

            $(".TablaMovimientosll").dataTable().fnClearTable();
            $.ajax({
                type: "POST",
                url: "WebService.asmx/DetalleLlantasMovimientos",
                data: "{ 'idLlanta': " + id + " }",
                dataType: 'json',
                contentType: "application/json; charset=utf-8",
                success: function (data) {
                    $.each(data.d, function (index, item) {

                        $(".TablaMovimientosll").dataTable().fnAddData([
                         item.codigo,
                         item.movimiento,
                         item.kmia,
                         item.fecha,
                         item.motivo,
                         item.encargado,
                         item.observaciones,
                        ]);


                    });
                },
                error: function (data) {
                    console.log(data);
                }

            });

        });

    });


    function ReporteTotalLLantas(event) {

        $.ajax({
            type: "POST",
            url: "WebService.asmx/ResumenTotalLlantas",
            contentType: "application/json; charset=utf-8",
            dataType: "json",

            success: function (data) {
                console.log(data.d);


                chart = new AmCharts.AmPieChart();

                // title of the chart


                chart = new AmCharts.AmPieChart();
                chart.addTitle("Resumen por marca", 16);
                chart.dataProvider = data.d;
                chart.titleField = "marca";
                chart.valueField = "total";
                chart.outlineColor = "#FFFFFF";
                chart.outlineAlpha = 0.8;
                chart.outlineThickness = 2;
                chart.balloonText = "[[title]]<br><span style='font-size:14px'><b>[[value]]</b> ([[percents]]%)</span>";




                // WRITE
                chart.write("chartdiv");
                chart.addListener("clickSlice", Detalle);
                chart.addListener("clickSlice", Detalle);




                //    // WRITE


            },
            error: function (data) { //console.log(data.responseText) 
            }
        });

    }
    function setLabelPosition() {
        if (document.getElementById("rb1").checked) {
            chart.labelRadius = 30;
            chart.labelText = "[[title]]: [[value]]";
        } else {
            chart.labelRadius = -30;
            chart.labelText = "[[percents]]%";
        }
        chart.validateNow();
    }
    function ReporteEstadoLLantas(event) {
        $.ajax({
            type: "POST",
            url: "WebService.asmx/ResumenDesgaste",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            data: "",
            success: function (data) {
                console.log(data);
                console.log(data.d);
                $.each(data.d, function (i, item) {
                    if (item.StrError != "0") {
                        jQuery.gritter.add({
                            title: 'Se Ha Producido Un Error!',
                            text: item.StrError,
                            class_name: 'growl-danger',
                            image: 'images/screen.png',
                            sticky: false,
                            time: ''
                        });
                        return;
                    }
                });


                chart = new AmCharts.AmSerialChart();
                chart.addTitle("Estado de desgate", 16);
                chart.dataProvider = data.d;
                chart.categoryField = "EstadoLLantas";
                chart.plotAreaBorderAlpha = 0.2;
                chart.rotate = true;


                // AXES
                // Category
                var categoryAxis = chart.categoryAxis;
                categoryAxis.gridAlpha = 0.1;
                categoryAxis.axisAlpha = 0;
                categoryAxis.gridPosition = "start";

                // value                      
                var valueAxis = new AmCharts.ValueAxis();
                valueAxis.stackType = "regular";
                valueAxis.gridAlpha = 0.1;
                valueAxis.axisAlpha = 0;

                chart.addValueAxis(valueAxis);

                // GRAPHS
                // firstgraph 
                var graph = new AmCharts.AmGraph();
                graph.title = "Buen Estado";
                graph.labelText = "([[percents]]%)";
                graph.valueField = "BuenEstado";
                graph.type = "column";
                graph.lineAlpha = 0;
                graph.fillAlphas = 1;
                graph.zoomable
                graph.lineColor = "#22DE0E";
                graph.balloonText = "<b><span style='color:#22DE0E'>[[title]]</b></span><br><span style='font-size:14px'><b>No. LLantas: </b>[[BuenEstado]]([[percents]]%) </span>";



                chart.depth3D = 20;
                chart.angle = 30;



                chart.addGraph(graph);
                //Gentrac Fin de semana
                var graph = new AmCharts.AmGraph();
                graph.title = "Regular Estado";
                graph.labelText = "([[percents]]%)";
                graph.valueField = "RegularEstado";
                graph.type = "column";
                graph.lineAlpha = 0;
                graph.fillAlphas = 1;
                graph.lineColor = "#FF8000";
                graph.balloonText = "<b><span style='color:#FF8000'>[[title]]</b></span><br><span style='font-size:14px'><b>No. LLantas: </b>[[RegularEstado]]([[percents]]%) </span>";


                chart.depth3D = 20;
                chart.angle = 30;
                chart.addGraph(graph);

                // Visitas                         
                graph = new AmCharts.AmGraph();
                graph.title = "Mal Estado";
                graph.labelText = "([[percents]]%)";
                graph.valueField = "MalEstado";
                graph.type = "column";
                graph.lineAlpha = 0;
                graph.fillAlphas = 1;
                graph.lineColor = "#FF0000";

                graph.balloonText = "<b><span style='color:#FF0000'>[[title]]</b></span><br><span style='font-size:14px'><b>No. LLantas: </b>[[MalEstado]]([[percents]]%) </span>";

                chart.depth3D = 20;
                chart.angle = 30;
                chart.addGraph(graph);







                // WRITE


                //chart.addListener("clickSlice", PorcentajePorDepartamento);
                chart.write("chartdiv1");
                $("#chartdiv1").show();

            },
            error: function (data) {
                jQuery.gritter.add({
                    title: 'Se Ha Producido Un Error!',
                    text: data.responseText,
                    class_name: 'growl-danger',
                    image: 'images/screen.png',
                    sticky: false,
                    time: ''
                });
            }
        });













    }


    function Detalle(event) {
        var codigo = event.dataItem.dataContext.codigo;
        $.ajax({
            type: "POST",
            url: "WebService.asmx/DetalleLlantasTotal",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            data: "{codigollanta:'" + codigo + "'}",
            success: function (data) {
                console.log(data.d);
                $.each(data.d, function (i, item) {
                    if (item.StrError != "0") {
                        //console.log(item)
                        jQuery.gritter.add({
                            title: 'Se Ha Producido Un Error!',
                            text: item.StrError,
                            class_name: 'growl-danger',
                            image: 'images/screen.png',
                            sticky: false,
                            time: ''
                        });
                        return;
                    }
                });


                chart1 = new AmCharts.AmPieChart();

                // title of the chart
                chart1.addTitle("Detalle Llantas", 16);

                chart1.dataProvider = data.d;
                chart1.titleField = "idllanta";
                chart1.valueField = "cantidad";
                chart1.sequencedAnimation = true;
                chart1.startEffect = "elastic";
                chart1.innerRadius = "30%";
                chart1.startDuration = 2;
                chart1.labelRadius = 15;
                chart1.pullOutOnlyOne = true;
                chart1.labelText = "";
                chart1.balloonText = "[[title]]<br><span style='font-size:14px'><b>[[cantidad]]</b> ([[percents]]%)</span>";
                // the following two lines makes the chart 3D
                chart1.depth3D = 10;
                chart1.angle = 15;

                // LEGEND                  
                var legend = new AmCharts.AmLegend();
                legend.borderAlpha = 0.2;
                legend.horizontalGap = 2;
                chart1.addLegend(legend);
                // WRITE                                 






                //                var legend = new AmCharts.AmLegend();
                //                legend.borderAlpha = 0.2;
                //                legend.horizontalGap = 10;
                //                chart1.addLegend(legend);
                // WRITE                   
                chart1.write("PieSubRendimiento");
                $("#PieSubRendimiento").show();




            },
            error: function (data) { //console.log(data.responseText) 
            }
        });

    }



    function ajustar(tam, num) {
        if (num.toString().length <= tam) return ajustar(tam, '0' + num)
        else return num;
    }

    $(document).ready(function () {

        $(".reporteLlantas tbody").on("click", ".BtnLlanta", function () {
            var id = this.id;



            $(".TablaMovimientosll").dataTable().fnClearTable();
            $.ajax({
                type: "POST",
                url: "WebService.asmx/DetalleLlantasGenerales",
                data: "{ 'idLlanta': " + id + " }",
                dataType: 'json',
                contentType: "application/json; charset=utf-8",
                success: function (data) {
                    $.each(data.d, function (index, item) {

                        $("#LblCodigo").text(item.idcodigo);
                        $("#LblDesgaste").text(item.desgaste);
                        $("#LblFecha").text(item.fecha);
                        $("#LblKilometraje").text(item.kilometraje);
                        $("#Lblrenkp").text(item.renkp);
                        $("#LblRenXTreinta").text(item.RendXtreinta);
                        $("#LblDesgasteAnt").text(item.desgastado);



                    });
                },
                error: function (data) {
                    console.log(data);
                }

            });

        });

    });





        </script>
</body>
</html>