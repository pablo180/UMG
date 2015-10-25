<%@ Page Language="VB" AutoEventWireup="false" CodeFile="reservavehiculo.aspx.vb" Inherits="privado_reservavehiculo" %>

<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0">
  <meta name="description" content="">
  <meta name="author" content="">
  <link rel="shortcut icon" href="images/favicon.png" type="image/png">

  <title>Reservación de Vehiculos | Monitoreo</title>
  <link rel="stylesheet" href="css/style.default.css" />
  <link rel="stylesheet" href="css/bootstrap-timepicker.min.css" />
  <link href="css/style.default.css" rel="stylesheet">
  <link href="css/jquery.gritter.css" rel="stylesheet">
  <link rel="stylesheet" href="css/colorpicker.css" />
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
      <h2><i class="fa fa-edit"></i> Reservación de Vehiculos <span>Extras...</span></h2>
    </div>
    
    <div class="contentpanel">
      
      <div class="panel panel-default">
      <form class="form-horizontal form-bordered" runat="server" id="formulario">
        <div class="panel-body panel-body-nopadding">                    
            <div class="form-group">
              <label class="col-sm-2 control-label">Nombre</label>
              <div class="col-sm-4">
                  <asp:TextBox ID="TxtNombreEmpleado" runat="server" CssClass="form-control" readonly></asp:TextBox>
              </div>
              <label class="col-sm-2 control-label">Correo</label>
              <div class="col-sm-4">
                <asp:TextBox ID="TxtCorreoEmpleado" runat="server" CssClass="form-control"></asp:TextBox>
              </div>
            </div>
            <div class="form-group">
                  <label class="col-sm-2 control-label">Lugar de Viaje</label>
                  <div class="col-sm-4">
                      <select class="form-control" id="DropLugarViaje">
                        <option value="FUERA">Fuera de Ciudad</option>
                        <option value="CIUDAD">Ciudad</option>
                      </select>
                  </div>
                  <label class="col-sm-2 control-label">Destino</label>
                  <div class="col-sm-4">
                    <div class="input-group mb15">
                      <input type="text" id="TxtDestino" class="form-control TxtDestino" placeholder="Pais, Departamento, Municipio, Zona, Direccion..." />
                      <span class="input-group-btn">
                        <button type="button" class="btn btn-default AddDestino">Add</button>
                      </span>
                    </div>
                  </div>
            </div>
            <div id="DivDestinos">
            
            </div>
            <div class="form-group">
              <label class="col-sm-2 control-label">Tipo de Vehiculo</label>
              <div class="col-sm-4">
              <asp:DropDownList ID="ListTipoVehiculo" runat="server" CssClass="form-control"></asp:DropDownList>
              </div>
              <label class="col-sm-2 control-label">Observaciones</label>
              <div class="col-sm-4">
                <input type="text" id="TxtObservaciones" class="form-control" />
              </div>
            </div>
            <div class="form-group">
              <label class="col-sm-2 control-label">Fecha Inicio</label>
              <div class="col-sm-4">
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
              <div class="col-sm-4">
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
              <label class="col-sm-2 control-label">Alerta</label>
              <div class="col-sm-4">
              <asp:DropDownList ID="ListAlerta" runat="server" CssClass="form-control"></asp:DropDownList>
              </div>
            </div> 
          
        </div><!-- panel-body -->
        <div class="panel-footer">
			 <div class="row">
				<div class="col-sm-1 col-sm-offset-10">
                    <input type="button" id="BtnAgregarReservacion" class="btn btn-primary" value="Reservar" />
				</div>
			 </div>
		  </div><!-- panel-footer -->
         </form>
      </div><!-- panel -->
    </div><!-- contentpanel -->
  </div><!-- mainpanel -->
</section>
<script src="js/jquery-1.10.2.min.js"></script>
<script src="js/jquery-migrate-1.2.1.min.js"></script>
<script src="js/jquery-ui-1.10.3.min.js"></script>
<script src="js/bootstrap.min.js"></script>
<script src="js/modernizr.min.js"></script>
<script src="js/jquery.sparkline.min.js"></script>
<script src="js/toggles.min.js"></script>
<script src="js/retina.min.js"></script>
<script src="js/jquery.cookies.js"></script>
<script src="js/jquery.autogrow-textarea.js"></script>
<script src="js/bootstrap-fileupload.min.js"></script>
<script src="js/bootstrap-timepicker.min.js"></script>
<script src="js/jquery.maskedinput.min.js"></script>
<script src="js/jquery.tagsinput.min.js"></script>
<script src="js/jquery.mousewheel.js"></script>
<script src="js/chosen.jquery.min.js"></script>
<script src="js/dropzone.min.js"></script>
<script src="js/colorpicker.js"></script>
<script src="js/jquery.gritter.min.js"></script>
<script src="js/custom.js"></script>
<script src="js/ion.sound.min.js"></script>
<script src="js/Script.js"></script>

<script>
    jQuery(document).ready(function () {

        $("#BtnAgregarReservacion").click(function () {
            if (validaCorreo($("#<%=TxtCorreoEmpleado.ClientID %>").val())) {
                var fechaInicial = $("#TxtFechaInicio").val() + " " + $("#TxtHoraInicio").val();
                var fechaFin = $("#TxtFechaFin").val() + " " + $("#TxtHoraFin").val();
                //var d = new Date();
                //var ahora = d.getFullYear() + "-" + d.getMonth() + "-" + d.getDay() + " " + d.getHours() + ":" + d.getMinutes();
                //alert(ahora);
                if ($("#TxtDestino").val() != "") {
                    var Destinos = new Array()
                    $(".TxtDestino").each(function () {
                        if ($(this).val().length > 0) {
                            Destinos.push({ Dest: $(this).val() });
                        }
                    });
                    console.log(JSON.stringify(Destinos));
                    if (fechaInicial < fechaFin) {
                        $.ajax({
                            type: "POST",
                            url: "WebService.asmx/GuardarReservacionVehiculo",
                            contentType: "application/json; charset=utf-8",
                            dataType: "json",
                            data: "{Correo:'" + $("#<%=TxtCorreoEmpleado.ClientID %>").val() + "', TipoVehiculo:'" + $("#<%=ListTipoVehiculo.ClientID %>").val() + "',Destino:" + JSON.stringify(Destinos) + ",FechaInicio: '" + fechaInicial + "',FechaFin:'" + fechaFin + "', Alerta:'" + $("#<%=ListAlerta.ClientID %>").val() + "', Observaciones:'" + $("#TxtObservaciones").val() + "' ,LugarViaje:'" + $("#DropLugarViaje").val() + "'}",
                            success: function (data) {
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
                                    } else {
                                        jQuery.gritter.add({
                                            title: 'Exito!',
                                            text: 'La Operacion Se Ha Realizado Correctamente.',
                                            class_name: 'growl-info',
                                            image: 'images/screen.png',
                                            sticky: false,
                                            time: ''
                                        });
                                        $(".TxtDestino").val("");
                                        $("#TxtObservaciones").val("");
                                        jQuery('#TxtFechaInicio, #TxtFechaFin').datepicker({
                                            numberOfMonths: 1,
                                            dateFormat: "yy-mm-dd",
                                            dayNamesMin: ["Do", "Lu", "Ma", "Mi", "Ju", "Vi", "Sa"],
                                            closeOnSelect: true,
                                            monthNames: ['Enero', 'Febrero', 'Marzo', 'Abril', 'Mayo', 'Junio', 'Julio', 'Agosto', 'Septiembre', 'Octubre', 'Noviembre', 'Diciembre']
                                        }).mask('9999-99-99').datepicker("setDate", new Date());
                                        jQuery('#TxtHoraInicio, #TxtHoraFin').timepicker({ showMeridian: false });
                                        return;

                                    }
                                });
                            },
                            error: function (data) {
                                //console.log(data.responseText);
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
                    } else {
                        jQuery.gritter.add({
                            title: 'Ha Ocurrido Un Error!',
                            text: 'La Fecha Ingresada es Incorrecta',
                            class_name: 'growl-danger',
                            image: 'images/screen.png',
                            sticky: false
                        });
                    }
                } else {
                    jQuery.gritter.add({
                        title: 'Ha Ocurrido Un Error!',
                        text: 'Debe Ingresar Destino',
                        class_name: 'growl-danger',
                        image: 'images/screen.png',
                        sticky: false
                    });
                }
            } else {
                jQuery.gritter.add({
                    title: 'Ha Ocurrido Un Error!',
                    text: 'El Correo Introducido En Invalido',
                    class_name: 'growl-danger',
                    image: 'images/screen.png',
                    sticky: false
                });
            }
        });
        // Tags Input
        jQuery('#tags').tagsInput({ width: 'auto' });

        // Textarea Autogrow
        jQuery('#autoResizeTA').autogrow();

        // Color Picker
        if (jQuery('#colorpicker').length > 0) {
            jQuery('#colorSelector').ColorPicker({
                onShow: function (colpkr) {
                    jQuery(colpkr).fadeIn(500);
                    return false;
                },
                onHide: function (colpkr) {
                    jQuery(colpkr).fadeOut(500);
                    return false;
                },
                onChange: function (hsb, hex, rgb) {
                    jQuery('#colorSelector span').css('backgroundColor', '#' + hex);
                    jQuery('#colorpicker').val('#' + hex);
                }
            });
        }

        // Date Picker
        //jQuery('.fecha').datepicker();

        jQuery('#TxtFechaInicio, #TxtFechaFin').datepicker({
            numberOfMonths: 1,
            dateFormat: "yy-mm-dd",
            dayNamesMin: ["Do", "Lu", "Ma", "Mi", "Ju", "Vi", "Sa"],
            closeOnSelect: true,
            monthNames: ['Enero', 'Febrero', 'Marzo', 'Abril', 'Mayo', 'Junio', 'Julio', 'Agosto', 'Septiembre', 'Octubre', 'Noviembre', 'Diciembre']
        }).mask('9999-99-99').datepicker("setDate", new Date());

        // Time Picker
        jQuery('#TxtHoraInicio, #TxtHoraFin').timepicker({ showMeridian: false });

        $("#DropLugarViaje").change(function () {
            if ($(this).val() == "CIUDAD") {
                $("#LblMensajeViaje").fadeIn();
                $.ionSound({
                    sounds: ["moneda"],
                    path: "sounds/",
                    volume: "1.0"
                });
                $.ionSound.play("moneda");
                jQuery.gritter.add({
                    title: '¡INFORMACION!',
                    text: "Estimado usuario te recordamos que dentro del perimetro de la ciudad puedes usar tu carro y verte beneficiado con un pago por cita programada.",
                    class_name: 'growl-danger',
                    image: 'images/is-money.png',
                    sticky: false,
                    time: '8000'
                });
            };
        });
        $("form").on("click", ".AddDestino", function () {
            var HtmlDestinos = '<div class="form-group"><label class="col-sm-2 control-label">Destino</label><div class="col-sm-4"><div class="input-group mb15"><input type="text" class="form-control TxtDestino" placeholder="Pais, Departamento, Municipio, Zona, Direccion..." /><span class="input-group-btn"><button type="button" class="btn btn-default AddDestino">Add</button></span></div></div><label class="col-sm-2 control-label">Destino</label><div class="col-sm-4"><div class="input-group mb15"><input type="text" class="form-control TxtDestino" placeholder="Pais, Departamento, Municipio, Zona, Direccion..." /><span class="input-group-btn"><button type="button" class="btn btn-default AddDestino">Add</button></span></div></div></div>';
            $("#DivDestinos").append(HtmlDestinos);
        });
    });
</script>
</body>
</html>
