<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Default.aspx.vb" Inherits="privado_Default" %>

<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0">
  <meta name="description" content="">
  <meta name="author" content="">
  <link rel="shortcut icon" href="images/favicon.png" type="image/png">

  <title>Dashboard | Monitoreo</title>

  <link href="css/style.default.css" rel="stylesheet">
  <link href="css/jquery.datatables.css" rel="stylesheet">
   

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
  <form id="Form1" runat=server>
    <asp:Button ID="MostrarAlerta" style="display:none;" runat="server" Text="Button"></asp:Button>
  </form>
    <div class="logopanel">
        <h1><span>[</span> Monitoreo <span>]</span></h1>
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
      <h2><i class="fa fa-home"></i> Dashboard</h2>
    </div>
  <%--  <%
        Dim MyDB As New MyDB
        Dim FechaVencimiento As Integer = MyDB.MySelectOneParameter("select DATEDIFF(VencimientoLicencia,NOW()) as FechaVencimiento FROM personal where idEmpleado=" & Request.Cookies("UserSettings")("IdPersonal") & " and not isnull(VencimientoLicencia);", "FechaVencimiento")
        If FechaVencimiento <= 0 Then
            
            %>--%>
                <div class="alert alert-danger" >
                    <button type="button" class="close" data-dismiss="alert" aria-hidden="true">×</button>
                    <strong>Advertencia!</strong> <a href="#" class="alert-link">Su Licencia de Conducir, ha vencido</a>, Por favor Comunicarse con departamento de Flota.
                </div> 
      <%--      <%
        ElseIf FechaVencimiento <= 31 And FechaVencimiento > 0 Then
            %>--%>
                <div class="alert alert-warning" >
                    <button type="button" class="close" data-dismiss="alert" aria-hidden="true">×</button>
                    <strong>Advertencia!</strong> <a href="#" class="alert-link">Su Licencia de Conducir, esta proxima a vencer</a>, Por favor Comunicarse con departamento de Flota.
                </div>
      <%--      <%
        End If
        %>--%>
    <div class="contentpanel">
      <div class="row">
        <div class="col-sm-6 col-md-3">
          <div class="panel panel-success panel-stat">
            <div class="panel-heading">
              
              <div class="stat">
                <div class="row">
                  <div class="col-xs-4">
                    <img src="images/is-user.png" alt="" />
                  </div>
                  <div class="col-xs-8">
                    <small class="stat-label">Visits Today</small>
                    <h1>900k+</h1>
                  </div>
                </div><!-- row -->
                
                <div class="mb15"></div>
                
                <div class="row">
                  <div class="col-xs-6">
                    <small class="stat-label">Pages / Visit</small>
                    <h4>7.80</h4>
                  </div>
                  
                  <div class="col-xs-6">
                    <small class="stat-label">% New Visits</small>
                    <h4>76.43%</h4>
                  </div>
                </div><!-- row -->
              </div><!-- stat -->
              
            </div><!-- panel-heading -->
          </div><!-- panel -->
        </div><!-- col-sm-6 -->
        
        <div class="col-sm-6 col-md-3">
          <div class="panel panel-danger panel-stat">
            <div class="panel-heading">
              
              <div class="stat">
                <div class="row">
                  <div class="col-xs-4">
                    <img src="images/is-document.png" alt="" />
                  </div>
                  <div class="col-xs-8">
                    <small class="stat-label">% Unique Visitors</small>
                    <h1>54.40%</h1>
                  </div>
                </div><!-- row -->
                
                <div class="mb15"></div>
                
                <small class="stat-label">Avg. Visit Duration</small>
                <h4>01:80:22</h4>
                  
              </div><!-- stat -->
              
            </div><!-- panel-heading -->
          </div><!-- panel -->
        </div><!-- col-sm-6 -->
        
        <div class="col-sm-6 col-md-3">
          <div class="panel panel-primary panel-stat">
            <div class="panel-heading">
              
              <div class="stat">
                <div class="row">
                  <div class="col-xs-4">
                    <img src="images/is-document.png" alt="" />
                  </div>
                  <div class="col-xs-8">
                    <small class="stat-label">Page Views</small>
                    <h1>300k+</h1>
                  </div>
                </div><!-- row -->
                
                <div class="mb15"></div>
                
                <small class="stat-label">% Bounce Rate</small>
                <h4>34.23%</h4>
                  
              </div><!-- stat -->
              
            </div><!-- panel-heading -->
          </div><!-- panel -->
        </div><!-- col-sm-6 -->
        
        <div class="col-sm-6 col-md-3">
          <div class="panel panel-dark panel-stat">
            <div class="panel-heading">
              
              <div class="stat">
                <div class="row">
                  <div class="col-xs-4">
                    <img src="images/is-money.png" alt="" />
                  </div>
                  <div class="col-xs-8">
                    <small class="stat-label">Today's Earnings</small>
                    <h1>$655</h1>
                  </div>
                </div><!-- row -->
                
                <div class="mb15"></div>
                
                <div class="row">
                  <div class="col-xs-6">
                    <small class="stat-label">Last Week</small>
                    <h4>$32,322</h4>
                  </div>
                  
                  <div class="col-xs-6">
                    <small class="stat-label">Last Month</small>
                    <h4>$503,000</h4>
                  </div>
                </div><!-- row -->
                  
              </div><!-- stat -->
              
            </div><!-- panel-heading -->
          </div><!-- panel -->
        </div><!-- col-sm-6 -->
      </div><!-- row -->
      
      <div class="row">
        <div class="col-sm-8 col-md-9">
          <div class="panel panel-default">
            <div class="panel-body">
              <div class="row">
                <div class="col-sm-8">
                  <h5 class="subtitle mb5">Grafica de Reservaciones </h5>
                  <div class="form-group">
                      <label class="col-sm-2 control-label">Desde</label>
                      <div class="col-sm-4">
                        <div class="panel panel-default">
                            <div class="input-group">
                                <input type="text" class="form-control fecha" placeholder="yyyy-mm-dd" id="TxtFechaInicio" />
                                <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                            </div>
                        </div>
                      </div>
                      <label class="col-sm-2 control-label">Hasta</label>
                      <div class="col-sm-4">
                        <div class="input-group">
                            <div class="bootstrap-timepicker"><input id="TxtFechaFin" type="text" class="form-control"/></div>
                            <span class="input-group-addon"><i class="glyphicon glyphicon-time"></i></span>
                        </div>
                      </div>
                    </div>
                  <div id="chartdiv" style="width: 100%; height: 400px;"></div>
                  <div class="col-sm-6" id="VehiculosPMes" style="width:500px; height:380px; display:none;"></div>
                </div><!-- col-sm-8 -->
                <div class="col-sm-4" >
                  <h5 class="subtitle mb5">Top de Reservaciones </h5>
                  
                  <div id="ReportePorcentajes">
                  </div>
                  
                </div><!-- col-sm-4 -->
              </div><!-- row -->
            </div><!-- panel-body -->
          </div><!-- panel -->
        </div><!-- col-sm-9 -->
        
          <div class="col-sm-4 col-md-3">
          
          <div class="panel panel-default">
            <div class="panel-body">
            <h5 class="subtitle mb5">Most Browser Used</h5>
            <p class="mb15">Duis autem vel eum iriure dolor in hendrerit in vulputate...</p>
            <div id="donut-chart2" style="text-align: center; height: 298px;"></div>
            </div><!-- panel-body -->
          </div><!-- panel -->
          
        </div><!-- col-sm-3 -->
        
      </div><!-- row -->
      
      <div class="row">
        
        <div class="col-sm-7">
          
   <div class="panel panel-default">
            <div class="panel-body">
            <h5 class="subtitle mb5">Top Rendimiento Vehiculos </h5>
                <div class="col-sm-6">
            <select id="DropCantidad" name="DropCantidad" style="width:100%; height: 40px;">
                        <option value="0">descendente</option>
                        <option value="1">Ascendente</option>

                     </select>
                    </div>
                    <div class="col-sm-6">
                 <select id="DropRango" name="DropCantidad" style="width:100%; height: 40px;">
                        <option value="10">10 <selected></option>
                        <option value="25">25</option>
                        <option value="50">50</option>
                        <option value="100">100</option>
                        <option value="125">125</option>


                     </select>
                        </div>
                <%-- <form runat="Server" id="filtro">--%>
                <%--       <div class="form-group">
              <label class="col-sm-2 control-label">Departamento</label>
              <div class="col-sm-4">
             <asp:DropDownList ID="DropDepartamentos" runat="server" CssClass="form-control">
                        </asp:DropDownList>
                        </div>
                        
              <div class="col-sm-6">

               

                        </div>

                        </div>--%>
                  <%--   </form>--%>
                <table class="table table-striped TablaVehiculoss" >
                    <thead>
                        <tr>
                            <th>Posicion </th>
                            <th>Vehiculo</th>
                            <th>Departamento</th>
                            <th>Kmts/Galon</th>
                        
                            <th></th>
                        </tr>
                    </thead>
                    <tbody>
                    </tbody>
                </table>
            
  <div class="modal fade ModalEditarVehiculo" tabindex="-1" role="dialog" aria-labelledby="mySmallModalLabel" data-backdrop="static" aria-hidden="true">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
        <div class="modal-header">
            <button aria-hidden="true" data-dismiss="modal" class="close" type="button">&times;</button>
            <h4 class="modal-title"><span style="display:none" id="LblModificar">Modificaion</span><span style="display:none" id="LblCrear">Creacion</span> de  Vehiculo a: <i><label id="Label1"></label></i></h4>
        </div>
        <div class="modal-body">
        <input type="hidden" id="Hidden1" />
            <div class="form-group">
                <label class="col-md-2">Codigo:</label>
                <div class="col-md-4">
                    <input type="hidden" id="textMDId" name="textMDId" class="form-control" readonly="readonly" />
                    <input type="text" id="textMDCodigo" name="TxtMDCodigo" class="form-control"readonly="readonly" />
                </div>
                <label class="col-md-2">Placa:</label>
                <div class="col-md-4">
                    <input type="text" id="textMDPlaca"  name="TxtMDPlaca" class="form-control" readonly="readonly"/>
                </div>
            </div>
            <div class="form-group">
                <label class="col-md-2">Kilometraje:</label>
                <div class="col-md-4">
                <input type="text" id="txtMDKilometraje"  name="TxtMDKilometraje" class="form-control"readonly="readonly" />
                </div>
               <label class="col-md-2">Marca:</label>
               <div class="col-md-4">
                <input type="text" id="txtMDMarca"  name="TxtMDmarca" class="form-control"readonly="readonly" />
                </div>
            </div>
            <div class="form-group">
                <label class="col-md-2">Linea:</label>
                 <div class="col-md-4">
                <input type="text" id="txtMDLinea"  name="TxtMDLinea" class="form-control"readonly="readonly" />
                </div>
                <label class="col-md-2">Modelo:</label>
                  <div class="col-md-4">
                <input type="text" id="txtMDModelo"  name="TxtMDModelo" class="form-control"readonly="readonly" />
                 </div>
            </div>
            <%--<div class="form-group">
                <label class="col-md-2">TipoVehiculo:</label>
                <div class="col-md-4">
                    <asp:DropDownList ClientIDMode="Static" ID="DropTipoVehiculo" runat="server" style="width:100%;"></asp:DropDownList>
                </div>
                <label class="col-md-2">Departamento:</label>
                <div class="col-md-4">
                    <asp:DropDownList  ClientIDMode="Static" ID="DropDepartamento" runat="server" style="width:100%;"></asp:DropDownList>
                </div>
            </div>
             <div class="form-group">
                <label class="col-md-2">Contable:</label>
                 <div class="col-md-4">
                <input type="text" id="txtMDContable"  name="TxtMDContable" class="form-control" />
                </div>
                <label class="col-md-2">Estatus:</label>
                  <div class="col-md-4">
                     <select id="DropEstatus" name="DropEstatus" style="width:100%;">
                        <option value="1">Activo</option>
                        <option value="0">Inactivo</option>
                     </select>
                 </div>
            </div>
             <div class="form-group">
                <label class="col-md-2">Cantidad de Llantas:</label>
                 <div class="col-md-2">
                    <input type="text" id="txtMDCllantas"  name="TxtMDCllantas" class="form-control" />
                </div>
                <label class="col-md-2">Llantas de repuesto:</label>
                  <div class="col-md-2">
                <input type="text" id="txtMDCllantasR"  name="TxtMDCllantasR" class="form-control" />
                 </div>
                <label class="col-md-2">Pool:</label>
                 <div class="col-md-2">
                    <div class="col-sm-7 control-label">
                        <div class="toggle toggle-primary" id="CheckPool"></div>
                    </div>
                </div>
            </div>
                   <div class="form-group">
                <label class="col-md-3">Usuario asignado:</label>
                 <div class="col-md-3">
                       <asp:DropDownList  ClientIDMode="Static" ID="DropUsuario" runat="server" style="width:100%;"></asp:DropDownList>
                </div>
                <label class="col-md-3">Correo de Encargado:</label>
                  <div class="col-md-3">
                <input type="text" id="TxtCOEncargado"  name="TxtCOEncargado" class="form-control" />
                 </div>
            
            </div>
            <div class="form-group">
                <div class="col-md-4">
                </div>
                 <div class="col-md-6">
                </div>
                <div class="col-md-2">
                    <div class="btn-demo">
                        <input type="button" id="BtnEditarV" class="btn btn-primary" value="Guardar" />
                        <input type="button" id="BtnGuardarV" class="btn btn-primary" value="Guardar" />
                       <div class="col-md-12"> 
                    
                </div>
            </div>
        </div>
    </div>--%>
  </div>
</div>
      </div>
    </div>





            </div><!-- panel-body -->
          </div><!-- panel -->
          
        </div><!-- col-sm-7 -->
        
        <div class="col-sm-5">
          
          <div class="panel panel-success">
            <div class="panel-heading padding5">
              <div id="line-chart" style="height: 248px;"></div>
            </div>
            <div class="panel-body">
              <div class="tinystat pull-left">
                <div id="sparkline" class="chart mt5"></div>
                <div class="datainfo">
                  <span class="text-muted">Average Sales</span>
                  <h4>$630,201</h4>
                </div>
              </div><!-- tinystat -->
              <div class="tinystat pull-right">
                <div id="sparkline2" class="chart mt5"></div>
                <div class="datainfo">
                  <span class="text-muted">Total Sales</span>
                  <h4>$139,201</h4>
                </div>
              </div><!-- tinystat -->
            </div>
          </div><!-- panel -->
          
        </div><!-- col-sm-6 -->
      </div><!-- row -->
      
      <div class="row">
        <div class="col-sm-6 col-md-4">
          <div class="panel panel-default widget-photoday">
            <div class="panel-body">
              <a href="" class="photoday"><img src="images/photos/photo1.png" alt="" /></a>
              <div class="photo-details">
                <h4 class="photo-title">Strawhat In The Beach</h4>
                <small class="text-muted"><i class="fa fa-map-marker"></i> San Franciso, California, USA</small>
                <small>By: <a href="">ThemePixels</a></small>
              </div><!-- photo-details -->
              <ul class="photo-meta">
                <li><span><i class="fa fa-eye"></i> 32,102</span></li>
                <li><a href="#"><i class="fa fa-heart"></i> 1,003</a></li>
                <li><a href="#"><i class="fa fa-comments"></i> 52</a></li>
              </ul>
            </div><!-- panel-body -->
          </div><!-- panel -->
        </div><!-- col-sm-6 -->
        
        <div class="col-sm-6 col-md-4">
          <div class="panel panel-default panel-alt widget-messaging">
          <div class="panel-heading">
              <div class="panel-btns">
                <a href="" class="panel-edit"><i class="fa fa-edit"></i></a>
              </div><!-- panel-btns -->
              <h3 class="panel-title">Messaging</h3>
            </div>
            <div class="panel-body">
              <ul>
                <li>
                  <small class="pull-right">Dec 10</small>
                  <h4 class="sender">Jennier Lawrence</h4>
                  <small>Lorem ipsum dolor sit amet...</small>
                </li>
                <li>
                  <small class="pull-right">Dec 9</small>
                  <h4 class="sender">Marsha Mellow</h4>
                  <small>Lorem ipsum dolor sit amet...</small>
                </li>
                <li>
                  <small class="pull-right">Dec 9</small>
                  <h4 class="sender">Holly Golightly</h4>
                  <small>Lorem ipsum dolor sit amet...</small>
                </li>
                <li>
                  <small class="pull-right">Dec 10</small>
                  <h4 class="sender">Jennier Lawrence</h4>
                  <small>Lorem ipsum dolor sit amet...</small>
                </li>
                <li>
                  <small class="pull-right">Dec 9</small>
                  <h4 class="sender">Marsha Mellow</h4>
                  <small>Lorem ipsum dolor sit amet...</small>
                </li>
              </ul>
            </div><!-- panel-body -->
          </div><!-- panel -->
        </div><!-- col-sm-6 -->
        
        <div class="col-sm-6 col-md-4">
          <div class="panel panel-dark panel-alt widget-quick-status-post">
          <div class="panel-heading">
              <div class="panel-btns">
                <a href="" class="panel-close">&times;</a>
                <a href="" class="minimize">&minus;</a>
              </div><!-- panel-btns -->
              <h3 class="panel-title">Quick Status Post</h3>
            </div>
            <div class="panel-body">
              <ul class="nav nav-tabs nav-justified">
                <li class="active"><a href="#post-status" data-toggle="tab"><i class="fa fa-pencil"></i> <strong>Status</strong></a></li>
                <li><a href="#post-photo" data-toggle="tab"><i class="fa fa-picture-o"></i> <strong>Photo</strong></a></li>
                <li><a href="#post-checkin" data-toggle="tab"><i class="fa fa-map-marker"></i> <strong>Check-In</strong></a></li>
              </ul>
              <div class="tab-content">
                <div id="post-status" class="tab-pane active">
                  <input type="text" class="form-control" placeholder="What's your status?" />
                </div>
                <div id="post-photo" class="tab-pane">
                  <input type="text" class="form-control" placeholder="Choose photo" />
                </div>
                <div id="post-checkin" class="tab-pane">
                  <input type="text" class="form-control" placeholder="Search location" />
                </div>
                <button class="btn btn-primary btn-block mt10">Submit Post</button>
              </div><!-- tab-content -->
              
            </div><!-- panel-body -->
          </div><!-- panel -->
          
          <div class="mb20"></div>
          
          <div class="row">
            <div class="col-xs-6">
              <div class="panel panel-warning panel-alt widget-today">
                <div class="panel-heading text-center">
                  <i class="fa fa-calendar-o"></i>
                </div>
                <div class="panel-body text-center">
                  <h3 class="today">Fri, Dec 13</h3>
                </div><!-- panel-body -->
              </div><!-- panel -->
            </div>
            
            <div class="col-xs-6">
              <div class="panel panel-danger panel-alt widget-time">
                <div class="panel-heading text-center">
                  <i class="glyphicon glyphicon-time"></i>
                </div>
                <div class="panel-body text-center">
                  <h3 class="today">4:50AM PST</h3>
                </div><!-- panel-body -->
              </div><!-- panel -->
            </div>
          </div>
        </div><!-- col-sm-6 -->
        
      </div>
      
    </div><!-- contentpanel -->
    
  </div><!-- mainpanel -->  
</section>


<script type="text/javascript" src="js/jquery-1.10.2.min.js"></script>
<script src="js/amCharts/amcharts.js" type="text/javascript"></script>
 <script src="js/amcharts/serial.js" type="text/javascript"></script>
<script type="text/javascript" src="js/jquery-migrate-1.2.1.min.js"></script>
<script type="text/javascript" src="js/jquery-ui-1.10.3.min.js"></script>
<script type="text/javascript" src="js/bootstrap.min.js"></script>
<script type="text/javascript" src="js/modernizr.min.js"></script>
<script type="text/javascript" src="js/jquery.sparkline.min.js"></script>
<script type="text/javascript" src="js/toggles.min.js"></script>
<script type="text/javascript" src="js/retina.min.js"></script>
<script type="text/javascript" src="js/jquery.cookies.js"></script>
<script type="text/javascript" src="js/flot/flot.min.js"></script>
<script type="text/javascript" src="js/flot/flot.resize.min.js"></script>
<script type="text/javascript" src="js/morris.min.js"></script>
<script type="text/javascript" src="js/raphael-2.1.0.min.js"></script>
<script type="text/javascript" src="js/jquery.datatables.min.js"></script>
<script type="text/javascript" src="js/chosen.jquery.min.js"></script>
<script type="text/javascript" src="js/custom.js"></script>
<script type="text/javascript" src="js/dashboard.js"></script>
<script type="text/javascript" src="js/script.js"></script>
<script type="text/javascript">
    jQuery('#TxtFechaInicio, #TxtFechaFin').datepicker({
        numberOfMonths: 1,
        dateFormat: "yy-mm-dd",
        dayNamesMin: ["Do", "Lu", "Ma", "Mi", "Ju", "Vi", "Sa"],
        closeOnSelect: true,
        monthNames: ['Enero', 'Febrero', 'Marzo', 'Abril', 'Mayo', 'Junio', 'Julio', 'Agosto', 'Septiembre', 'Octubre', 'Noviembre', 'Diciembre']
    }).datepicker("setDate", new Date());
    //       jQuery('#TxtHoraInicio, #TxtHoraFin').timepicker({ showMeridian: false });
    $(document).ready(function () {


        $("#TxtFechaInicio, #TxtFechaFin").change(function () {
            console.log("prueb");
            if ($("#TxtFechaInicio").val() != "" && $("#TxtFechaFin").val() != "") {
                ReporteUtilizacio();
                ReportePorcentaje();
                TopTenRendimientoo($("#DropCantidad").val());
            }
        });

        $("#DropCantidad").change(function () {

            TopTenRendimientoo($("#DropCantidad").val());

        });
        $("#DropRango").change(function () {

            TopTenRendimientoo($("#DropRango").val());

        });
    });
    jQuery(document).ready(function () {
        $(".TablaVehiculos").dataTable();

    });
    function ReporteUtilizacio() {
        $.ajax({
            type: "POST",
            url: "WebService.asmx/ReporteUtilizacion",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            data: "{FechaIni:'" + $("#TxtFechaInicio").val() + "',FechaFin:'" + $("#TxtFechaFin").val() + "'}",
            success: function (data) {
                console.log(data.d);

                // SERIAL CHART
                chart = new AmCharts.AmSerialChart();
                chart.dataProvider = data.d;
                chart.categoryField = "Fecha";
                // the following two lines makes chart 3D
                chart.depth3D = 20;
                chart.angle = 30;


                // AXES
                // category
                var categoryAxis = chart.categoryAxis;
                categoryAxis.dashLength = 5;
                categoryAxis.labelRotation = 35;
                categoryAxis.gridPosition = "start";

                // GRAPH            
                var graph = new AmCharts.AmGraph();
                graph.valueField = "Cantidad";
                graph.colorField = "color";
                graph.balloonText = "<span style='font-size:14px'>[[category]]: <b>[[value]]</b></span>";
                graph.type = "column";
                graph.lineAlpha = 0;
                graph.fillAlphas = 1;
                chart.addGraph(graph);

                // CURSOR
                var chartCursor = new AmCharts.ChartCursor();
                chartCursor.cursorAlpha = 0;
                chartCursor.zoomable = false;
                chartCursor.categoryBalloonEnabled = false;
                chart.addChartCursor(chartCursor);

                // Linea 2
                var graph2 = new AmCharts.AmGraph();



                graph2.type = "line";
                graph2.lineColor = "#fcd202";
                graph2.valueField = "CantidadVehiculos";
                graph2.lineThickness = 3;
                graph2.bullet = "round";
                graph2.bulletBorderThickness = 3;
                graph2.bulletBorderColor = "#fcd202";
                graph2.bulletBorderAlpha = 1;
                graph2.bulletColor = "#ffffff";
                graph2.dashLengthField = "dashLengthLine";
                graph2.balloonText = "<span style='font-size:13px;'><b>[[value]]</b> Vehiculos</span><br /><span style='font-size:13px;'>Utilizacion <b>[[utilizacion]]</b> a <b>1</b></span>";
                chart.addGraph(graph2);
                // WRITE
                chart.write("chartdiv");

            }

        });
    }
    function ReportePorcentaje() {
        $.ajax({
            type: "POST",
            url: "WebService.asmx/ReporteUtilizacionLineas",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            data: "{FechaIni:'" + $("#TxtFechaInicio").val() + "',FechaFin:'" + $("#TxtFechaFin").val() + "'}",
            success: function (data) {
                console.log(data.d);
                $("#ReportePorcentajes").html('');
                $.each(data.d, function (index, item) {
                    $("#ReportePorcentajes").append('<span class="sublabel">' + item.Departamento + ' (' + item.CantidadLi + ' - ' + item.Porcentaje + '%)</span><div class="progress progress-sm"><div style="width: ' + item.Porcentaje + '%" aria-valuemax="100" aria-valuemin="0" aria-valuenow="' + item.Porcentaje + '" role="progressbar" class="progress-bar progress-bar-primary"></div></div><!-- progress -->');
                });
            }

        });
    }

    function TopTenRendimientoo(id) {
        $.ajax({
            type: "POST",
            url: "WebService.asmx/TopRendimientoG",
            data: "{'IdVehiculo': " + id + ",FechaIni:'" + $("#TxtFechaInicio").val() + "',FechaFin:'" + $("#TxtFechaFin").val() + "',Rango:'" + $("#DropRango").val() + "'}",
            dataType: 'json',
            contentType: "application/json; charset=utf-8",
            success: function (data) {
                console.log(data.d);
                $(".TablaVehiculoss tbody").html("");
                $.each(data.d, function (index, item) {
                    $(".TablaVehiculoss tbody").append("<tr class='success'><td class='active'>" + (index + 1) + "</td><td class='success'><a name='documento' href='#'> " + item.codigo + "</a></td><td>" + item.departamento + "</td><td>" + item.Promedio + "</td></tr>");
                });
                $("tr>td>a").click(function (event) {
                    event.preventDefault();
                    var id = event.srcElement.innerText;
                    $.ajax({
                        type: "POST",
                        url: "WebService.asmx/InfoVehiculo",
                        data: "{ 'IdVehiculo': '" + id + "' }",
                        dataType: 'json',
                        contentType: "application/json; charset=utf-8",
                        success: function (data) {
                            $.each(data.d, function (index, item) {
                                $("#textMDId").val(item.Id);
                                // $("#textMDPool").val(item.poolv);
                                $("#textMDCodigo").val(item.codigo);
                                $("#textMDPlaca").val(item.placa);
                                $("#txtMDKilometraje").val(item.kma);
                                $("#txtMDMarca").val(item.marca);
                                $("#txtMDLinea").val(item.linea);
                                $("#txtMDModelo").val(item.modelo);
                                //$('#DropTipoVehiculo').val(item.idtipovehiculo).trigger("chosen:updated");
                                //$('#DropDepartamento').val(item.iddepartamento).trigger("chosen:updated");
                                //$('#DropUsuario').val(item.usuario).trigger("chosen:updated");
                                //$("#txtMDContable").val(item.contable);
                                //$('#DropEstatus').val(item.status).trigger("chosen:updated");
                                //$('#TxtCOEncargado').val(item.Correo).trigger("chosen:updated");
                                //if (item.status) {
                                //    $('#DropEstatus').val(1).trigger("chosen:updated");
                                //} else {
                                //    $('#DropEstatus').val(0).trigger("chosen:updated");
                                //}
                                // $("#DropEstatus").val(item.status);
                            //    $("#txtMDCllantas").val(item.cllantas);
                            //    $("#txtMDCllantasR").val(item.repuesto);
                            //    if (item.pool) {
                            //        $("#CheckPool").toggles({ on: true });
                            //    }
                            });
                            $('.ModalEditarVehiculo').modal('toggle');
                        },
                        error: function (data) {
                            console.log(data);
                        }
                    });
                    console.log(event);
                    console.log(event.srcElement.innerText);



                    
                    //var serie = $(this).html();
                    //FcrearPDF(serie);
                });
              
            },
            error: function (data) {
                console.log(data);
            }
        });
    }
  
</script>
</body>
</html>
