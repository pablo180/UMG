<%@ Page Language="VB" AutoEventWireup="false" CodeFile="mantenimientos.aspx.vb" Inherits="privado_mantenimientos" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="es"
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0">
  <meta name="description" content="">
  <meta name="author" content="">
  <link rel="shortcut icon" href="images/favicon.png" type="image/png">
  <title>Mantenimientos | <%=datos.addKey("NameProject")%></title>
  <link rel="stylesheet" href="css/style.default.css" />
  <link rel="stylesheet" href="css/bootstrap-fileupload.min.css" />
  <link rel="stylesheet" href="css/bootstrap-timepicker.min.css" />
  <link rel="stylesheet" href="css/jquery.tagsinput.css" />
  <link rel="stylesheet" href="css/colorpicker.css" />
  <link rel="stylesheet" href="css/dropzone.css" />
  <link rel="stylesheet" href="css/autocomplete.css" />
  <link rel="Stylesheet" href="css/jquery-ui.css" />
  <link href="css/style.default.css" rel="stylesheet" />
  <link href="css/jquery.gritter.css" rel="stylesheet" />
  <link rel="stylesheet" href="css/colorpicker.css" />
  <link rel="Stylesheet" href="css/jquery-ui.css" />
  <!--<link rel="Stylesheet" href="contextMenu/jquery.contextMenu.css" />-->
  <!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
  <!--[if lt IE 9]>
  <script src="js/html5shiv.js"></script>
  <script src="js/respond.min.js"></script>
  <![endif]-->
<style>
td
{
    border: solid 4px #FFFFFF;
    }
</style>
</head>
<body>
<div id="preloader">
    <div id="status"><i class="fa fa-spinner fa-spin"></i></div>
</div>
<form class="form-horizontal form-bordered" runat="server" id="formulario">
<section>
  <div class="leftpanel">
    <div class="logopanel">
        <h1><span>[</span> <%=datos.addKey("NameProject")%> <span>]</span></h1>
    </div>
    <div class="leftpanelinner">
        <!-- #include file="usuario.html"-->
      <h5 class="sidebartitle">Men&uacute;</h5>
      <!--#include file="menu.html" -->
    </div>
  </div>
  <div class="mainpanel">
    <div class="headerbar">
      <a class="menutoggle"><i class="fa fa-bars"></i></a>
      <!-- #INCLUDE FILE="usuariomenu.html" --> 
    </div><!-- headerbar -->   
    <div class="pageheader">
      <h2><i class="fa fa-calendar"></i> Mantenimiento Preventivo <span>Reportes...</span></h2>
      <div class="breadcrumb-wrapper">
      </div>
    </div>
    <div class="contentpanel">
  <div class="form-group">
    <label for="DropDepartamento">Departamento</label>
    <asp:DropDownList ID="DropDepartamento" runat="server" style="width:100%;"></asp:DropDownList>
  </div>
    </div>
    <div class="contentpanel">
        <div class="row">
            <div class="col-md-12">
              <div class="panel panel-default">
                    <div class="table-responsive">
                        <table class="table mb30 TblMantenimientos">
                            <thead>
                                <tr>
                                    <th>Unidad</th>
                                    <th>Kilometraje</th>
                                    <th>Motor</th>
                                    <th>Transmisión</th>
                                    <th>Diferencial</th>
                                </tr>
                            </thead>
                            <tbody>
                            </tbody>
                        </table>
                    </div>
              </div>
            </div>
          </div>
    </div>
  </div>
<div class="modal fade InfoMotor" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
        <div class="modal-header">
            <button aria-hidden="true" data-dismiss="modal" class="close" type="button">&times;</button>
            <h4 class="modal-title">Informacion de Motor: <i><label id="LblVehiculoMotor"></label></i></h4>
        </div>
        <div class="modal-body">
            <input id="TxtIdCompetidor" type="hidden" readOnly />
            <div class="row">
              <div class="form-group">
                <label class="col-sm-2 control-label">Km Total de Unidad</label>
                <div class="col-md-4">
                  <input id="TxtKmTotalMotor" type="text" class="form-control" readOnly />
                </div>
                <label class="col-sm-2 control-label">Km Ultimo Servicio</label>
                <div class="col-md-4">
                  <input id="TxtKmUltimoServicioMotor" type="text" class="form-control" readOnly />
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-2 control-label">Tipo Ultimo Servicio</label>
                <div class="col-md-4">
                  <input id="TxtTipoUltimoServicioMotor" type="text" class="form-control" readOnly />
                </div>
                <label class="col-sm-2 control-label">Orden de Trabajo</label>
                <div class="col-md-4">
                  <input id="TxtOrdenTrabajoMotor" type="text" class="form-control" readOnly />
                </div>
              </div>
            </div>
        </div>
    </div>
  </div>
</div>
<div class="modal fade OTMotor" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
        <div class="modal-header">
            <button aria-hidden="true" data-dismiss="modal" class="close" type="button">&times;</button>
            <h4 class="modal-title">Orden de Trabajo para: <i><label id="LblVehiculoOrdenMotor"></label></i></h4>
        </div>
        <div class="modal-body">
            <input id="TxtIdVehiculoMotor" type="hidden" readOnly>
            <div class="row">
              <div class="form-group">
                <label class="col-sm-2 control-label">Fecha Inicio</label>
                <div class="col-md-4">
                    <div class="panel panel-default">
                        <div class="input-group">
                            <input type="text" class="form-control fecha" placeholder="yyyy-mm-dd" id="TxtFechaInicio" />
                            <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                        </div>
                    </div>
                </div>
                <label class="col-sm-2 control-label">Hora Inicio</label>
                  <div class="col-sm-4">
                    <div class="input-group">
                        <div class="bootstrap-timepicker"><input id="TxtHoraInicio" type="text" class="form-control"/></div>
                        <span class="input-group-addon"><i class="glyphicon glyphicon-time"></i></span>
                    </div>
                  </div>
             </div>
             <div class="form-group">
                <label class="col-sm-2 control-label">Fecha Fin</label>
                <div class="col-md-4">
                    <div class="panel panel-default">
                        <div class="input-group">
                            <input type="text" class="form-control" placeholder="yyyy-mm-dd" id="TxtFechaFin" />
                            <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                        </div>
                    </div>
                </div>
                <label class="col-sm-2 control-label">Hora Fin</label>
                  <div class="col-sm-4">
                    <div class="input-group">
                        <div class="bootstrap-timepicker"><input id="TxtHoraFin" type="text" class="form-control"/></div>
                        <span class="input-group-addon"><i class="glyphicon glyphicon-time"></i></span>
                    </div>
                  </div>
              </div>
              <div class="form-group">
                <label class="col-sm-2 control-label">Encargado</label>
                <div class="col-md-4">
                  <input id="TxtEncargado" type="text" class="form-control"  />
                </div>
                <label class="col-sm-2 control-label">Destino</label>
                <div class="col-md-4">
                  <asp:DropDownList ID="DropDestino" runat="server" CssClass="form-control"></asp:DropDownList>
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-2 control-label">Descripcion</label>
                <div class="col-md-10">
                  <input id="TxtDescripcion" type="text" class="form-control"  />
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-2 control-label">Servicio</label>
                <div class="col-md-4">
                    <asp:DropDownList ID="DropServicio" runat="server" CssClass="form-control"></asp:DropDownList>
                </div>
                <label class="col-sm-2 control-label">Observación</label>
                <div class="col-md-4">
                  <input id="TxtObservacion" type="text" class="form-control"  />
                </div>
              </div>
              <div class="form-group">
                <div class="row">
			        <div class="col-sm-1 col-sm-offset-10">
                        <input type="button" id="BtnAgregarServicio" class="btn btn-primary" value="Agregar" />
			        </div>
			    </div>
              </div>
              <div class="form-group">
                <div class="row">
                    <div class="col-md-12">
                        <div class="panel panel-default">
                            <div class="table-responsive">
                                <table class="table mb30 TblServicios">
                                    <thead>
                                        <tr>
                                            <th>Servicio</th>
                                            <th>Observación</th>
                                            <th></th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                    </tbody>
                                </table>
                            </div>
                        </div><!-- panel -->
                    </div><!-- col-md-12 -->
                </div><!-- row -->
            </div>
        </div>
        <div class="panel-footer">
			<div class="row">
			<div class="col-sm-1 col-sm-offset-10">
                <input type="button" id="BtnGuardarOT" class="btn btn-primary" value="Guardar" />
			</div>
			</div>
		</div><!-- panel-footer -->
    </div>
  </div>
</div>
</section>
</form>
<script type="text/javascript" src="js/jquery-1.10.2.min.js"></script>
<script type="text/javascript" src="js/jquery-migrate-1.2.1.min.js"></script>
<script type="text/javascript" src="js/jquery-ui-1.10.3.min.js"></script>
<script type="text/javascript" src="js/bootstrap.min.js"></script>
<script type="text/javascript" src="js/modernizr.min.js"></script>
<script type="text/javascript" src="js/jquery.sparkline.min.js"></script>
<script type="text/javascript" src="js/toggles.min.js"></script>
<script type="text/javascript" src="js/retina.min.js"></script>
<script type="text/javascript" src="js/jquery.cookies.js"></script>
<script type="text/javascript" src="js/jquery.autogrow-textarea.js"></script>
<script type="text/javascript" src="js/bootstrap-fileupload.min.js"></script>
<script type="text/javascript" src="js/bootstrap-timepicker.min.js"></script>
<script type="text/javascript" src="js/jquery.maskedinput.min.js"></script>
<script type="text/javascript" src="js/jquery.tagsinput.min.js"></script>
<script type="text/javascript" src="js/jquery.mousewheel.js"></script>
<script type="text/javascript" src="js/chosen.jquery.min.js"></script>
<script type="text/javascript" src="js/dropzone.min.js"></script>
<script type="text/javascript" src="js/colorpicker.js"></script>
<script type="text/javascript" src="js/jquery.gritter.min.js"></script>
<script type="text/javascript" src="js/custom.js"></script>
<script type="text/javascript" src="js/ion.sound.min.js"></script>
<!--<script type="text/javascript" src="contextMenu/jquery.contextMenu.js"></script>-->
<script type="text/javascript" src="js/Script.js"></script>
<script type="text/javascript" >
    jQuery(document).ready(function () {
        $("#<%=DropDepartamento.ClientID %>").change(function () {
            LlenarTabla($(this).val());
        });
        LlenarTabla('0');
        var arrayMotor = new Array();
        $(".TblMantenimientos tbody").on("contextmenu", "tr .btnMotor, tr .btnDiferencial, tr .btnTransmision", function (e) {
            if (e.button == 2) {
                $("#TxtIdVehiculoMotor").val($(this).parent().attr("id").split("_")[1]);
                $("#LblVehiculoOrdenMotor").html($(this).parent().find("td:eq(0)").html());
                $(".TblServicios tbody").html("");
                $(".OTMotor").modal("toggle");
                $("#TxtObservacion").val("");
                $("#TxtEncargado").val("");
                arrayMotor = [];
                return false;
            }
        });
        $(".TblMantenimientos tbody").on("click", "tr .btnMotor, tr .btnTransmision, tr .btnDiferencial", function (e) {
            $("#TxtIdVehiculoMotor").val($(this).parent().attr("id").split("_")[1]);
            $("#LblVehiculoOrdenMotor").html($(this).parent().find("td:eq(0)").html());
            $(".TblServicios tbody").html("");
            $(".OTMotor").modal("toggle");
            $("#TxtObservacion").val("");
            $("#TxtEncargado").val("");
            arrayMotor = [];
        });

        jQuery('#TxtFechaInicio, #TxtFechaFin').datepicker({
            numberOfMonths: 1,
            dateFormat: "yy-mm-dd",
            dayNamesMin: ["Do", "Lu", "Ma", "Mi", "Ju", "Vi", "Sa"],
            closeOnSelect: true,
            monthNames: ['Enero', 'Febrero', 'Marzo', 'Abril', 'Mayo', 'Junio', 'Julio', 'Agosto', 'Septiembre', 'Octubre', 'Noviembre', 'Diciembre']
        }).datepicker("setDate", new Date()).mask('9999-99-99');
        // Time Picker
        jQuery('#TxtHoraInicio, #TxtHoraFin').timepicker({ showMeridian: false });
        $("#BtnGuardarOT").click(function () {
            console.log(arrayMotor);
            $.ajax({
                type: "POST",
                url: "WebService.asmx/GuardarReservaMantenimiento",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                data: "{ IdVehiculo: '" + $("#TxtIdVehiculoMotor").val() + "',Fecha: '" + $("#TxtFechaInicio").val() + "', FechaInicio: '" + $("#TxtFechaInicio").val() + " " + $("#TxtHoraInicio").val() + "', FechaFin: '" + $("#TxtFechaFin").val() + " " + $("#TxtHoraFin").val() + "', Encargado:'" + $("#TxtEncargado").val() + "', Destino: '" + $("#DropDestino").val() + "',Descripcion:'" + $("#TxtDescripcion").val() + "', Servicio:" + JSON.stringify(arrayMotor) + ", Observacion:'" + $("#TxtObservacion").val() + "' }",
                success: function (data) {
                    $.each(data.d, function (i, item) {
                        if (item.StrError == "0") {
                            jQuery.gritter.add({
                                title: 'Exito!',
                                text: 'El Ingreso se ha realizado correctamente.',
                                class_name: 'growl-success',
                                image: 'images/screen.png',
                                sticky: false,
                                time: ''
                            });
                            $("input").val("");
                        } else {
                            jQuery.gritter.add({
                                title: 'Se Ha Producido Un Error!',
                                text: item.StrError,
                                class_name: 'growl-danger',
                                image: 'images/screen.png',
                                sticky: false,
                                time: ''
                            });
                        }
                    });
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
                },
                complete: function () { $(".OTMotor").modal("toggle"); }
            });
        });
        $("#BtnAgregarServicio").click(function () {
            $(".TblServicios tbody").append("<tr><td>" + $("#DropServicio").find(":selected").html() + "</td><td>" + $("#TxtObservacion").val() + "</td><td><input type='button' value='Dar de Baja' class='btn btn-danger btn-xs BtnBajaItemMotor' /></td></tr>");
            arrayMotor.push({ Servicio: $("#DropServicio").val(), Observacion: $("#TxtObservacion").val() });
            $("#TxtObservacion").val("");
        });
        $(".TblServicios tbody").on("click", "tr td .BtnBajaItemMotor", function () {
            arrayMotor.splice($(this).parent().parent().index(), 1);
            $(this).parent().parent().remove();
        });
    });
    function LlenarTabla(q) {
        $.ajax({
            type: "POST",
            url: "WebService.asmx/DetalleDetalleMantenimiento",
            data: "{q:'" + q + "'}",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (data) {
                $(".TblMantenimientos tbody").html("");
                $.each(data.d, function (i, item) {
                    $(".TblMantenimientos tbody").append("<tr id='row_" + item.Id + "'><td>" + item.Codigo + "</td><td>" + item.Kilometraje + "</td><td class='" + item.ClassMotor + " btnMotor' style='cursor:pointer;' id='motor_" + item.Id + "'>" + item.DiferenciaMotor + "</td><td class='" + item.ClassTransmision + " btnTransmision' style='cursor:pointer;' id='transmision_" + item.Id + "'>" + item.DiferenciaTransmision + "</td><td class='" + item.ClassDiferencial + " btnDiferencial' style='cursor:pointer;' id='diferencial" + item.Id + "'>" + item.DiferenciaDiferencial + "</td></tr>");
                })
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
</script>
</body>
</html>
