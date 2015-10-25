<%@ Page Language="VB" AutoEventWireup="false" CodeFile="estadoactualvehiculo.aspx.vb" Inherits="privado_estadoactualvehiculo" %>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0">
  <meta name="description" content="">
  <meta name="author" content="">
  <link rel="shortcut icon" href="images/favicon.png" type="image/png">
  <title>Estado Vehiculo | Monitoreo</title>
  <link href="css/style.default.css" rel="stylesheet">
  <link href="css/amCharts.css" rel="stylesheet" type="text/css" />
  <link href="css/jquery.datatables.css" rel="stylesheet">
  <link href="css/jquery.gritter.css" rel="stylesheet">
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
      <h2><i class="fa fa-exchange"></i> Estado Vehiculo <span>Reportes</span></h2>
    </div>
    <div class="contentpanel">
      <div class="row">
        <div class="col-md-12">
          <div class="panel panel-default">
            <div class="panel-heading">
              
              <!--<h4 class="panel-title">Filtros:</h4>
              <form runat="Server" id="filtro">
                <div class="form-group">
                    <label class="col-sm-2">Departamento:</label>
                    <div class="col-sm-4">
                       <asp:DropDownList ID="DropDepartamentos" runat="server" CssClass="form-control"></asp:DropDownList>
                    </div>
                    <label class="col-sm-2">Año:</label>
                    <div class="col-sm-4">
                       <asp:DropDownList ID="DropYear" runat="server" CssClass="form-control"></asp:DropDownList>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-2">Mes:</label>
                    <div class="col-sm-4">
                       <asp:DropDownList ID="DropMes" runat="server" CssClass="form-control"></asp:DropDownList>
                    </div>
                </div>
            </form>-->
            </div>
            <div class="panel-body panel-body-nopadding">
              <!-- BASIC WIZARD -->
              <div id="basicWizard" class="basic-wizard">
                <!--<ul class="nav nav-pills nav-justified">
                  <li><a href="#tab1" data-toggle="tab"><span>Rendimiento:</span> Combustible</a></li>
                  <li><a href="#tab2" data-toggle="tab"><span>Rendimiento:</span> Aceite de Motor</a></li>
                  <li><a href="#tab3" data-toggle="tab"><span>Rendimiento:</span> Aceite de Caja</a></li>
                  <li><a href="#tab1" data-toggle="tab"><span>Kilometrajes:</span></a></li>
                </ul>-->
                <div class="tab-content">
                  <div class="row" id="tab1">
                    <div class="table-responsive">
                      <table class="table mb30 TblEstadoVehiculo">
                        <thead>
                          <tr>
                            <th>Vehiculo</th>
                            <th>Pertenece a</th>
                          </tr>
                        </thead>
                        <tbody>
                        </tbody>
                      </table>
                      </div><!-- table-responsive -->
                  </div>
                 
                </div><!-- tab-content -->
                <%--<ul class="pager wizard">
                    <li class="previous"><a href="javascript:void(0)">Previous</a></li>
                    <li class="next"><a href="javascript:void(0)">Next</a></li>
                  </ul>--%>
              </div><!-- #basicWizard -->
            </div><!-- panel-body -->
          </div><!-- panel -->
        </div><!-- col-md-12 -->
      </div><!-- row -->
    </div><!-- contentpanel -->
  </div><!-- mainpanel -->
</section>
<script type="text/javascript" src="js/jquery-1.10.2.min.js"></script>
<script type="text/javascript" src="js/jquery-migrate-1.2.1.min.js"></script>
<script type="text/javascript" src="js/bootstrap.min.js"></script>
<script type="text/javascript" src="js/modernizr.min.js"></script>
<script type="text/javascript" src="js/jquery.sparkline.min.js"></script>
<script type="text/javascript" src="js/toggles.min.js"></script>
<script type="text/javascript" src="js/retina.min.js"></script>
<script type="text/javascript" src="js/jquery.cookies.js"></script>
<script type="text/javascript" src="js/amCharts/amcharts.js" type="text/javascript"></script>
<script type="text/javascript" src="js/amCharts/pie.js" type="text/javascript"></script>
<script type="text/javascript" src="js/amCharts/serial.js" type="text/javascript"></script>
<script type="text/javascript" src="js/bootstrap-wizard.min.js"></script>
<script type="text/javascript" src="js/jquery.validate.min.js"></script>
<script type="text/javascript" src="js/chosen.jquery.min.js"></script>
<script type="text/javascript" src="js/custom.js"></script>
<script type="text/javascript" src="js/jquery.datatables.min.js"></script>
<script type="text/javascript" src="js/jquery.gritter.min.js"></script>
<script type="text/javascript">
    jQuery(document).ready(function () {
        jQuery("select").chosen({ 'width': '100%', 'white-space': 'nowrap' });
    });
    $(document).ready(function () {
        var UbicacionVehiculo = "";
        $.ajax({
            type: "POST",
            url: "WebService.asmx/UbicacionVehiculo",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            async: false,
            success: function (data) {
                if (data.d.length != 0) {
                    UbicacionVehiculo = data.d
                    $.each(data.d, function (index, item) {
                        if (item.StrError == "0") {
                            $(".TblEstadoVehiculo thead tr").append("<th>" + item.Descripcion + "</th>");
                        } else {
                            //console.log(data.d);
                        }
                    });
                    $.ajax({
                        type: "POST",
                        url: "WebService.asmx/DetalleUbicacionVehiculo",
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        async: false,
                        success: function (msg) {
                            if (msg.d.length != 0) {
                                $.each(msg.d, function (index, item) {
                                    if (item.StrError == "0") {
                                        $(".TblEstadoVehiculo tbody").append("<tr id='" + item.Id + "'><td>" + item.Codigo + "</td>");
                                        if (item.Pool == true) {
                                            if (item.IdUbicacion == "0") {
                                                $(".TblEstadoVehiculo tbody #" + item.Id).append("<td>Pendiente de Entregar a Pool</td>");
                                            } else {
                                                $(".TblEstadoVehiculo tbody #" + item.Id).append("<td>Pool</td>");
                                            }
                                            
                                        } else {
                                            $(".TblEstadoVehiculo tbody #" + item.Id).append("<td>Colaborador</td>");
                                        }
                                        $.each(UbicacionVehiculo, function (index, i) {
                                            if (i.StrError == "0") {
                                                if (item.IdUbicacion == i.Id) {
                                                    $(".TblEstadoVehiculo tbody #" + item.Id).append("<td class='btn-success'></td>");
                                                } else {
                                                    $(".TblEstadoVehiculo tbody #" + item.Id).append("<td></td>");
                                                }
                                            }
                                        });
                                    }
                                });

                            }
                        }
                    });
                }
            }
        });
        //console.log(UbicacionVehiculo);
    });
</script>
</body>
</html>
