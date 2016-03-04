<%@ Page Language="VB" AutoEventWireup="false" CodeFile="vehiculos.aspx.vb" Inherits="privado_vehiculos" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html lang="es">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0">
  <meta name="description" content="">
  <meta name="author" content="">
  <link rel="shortcut icon" href="images/favicon.png" type="image/png">
  <title>Vehiculos | <%=datos.addKey("NameProject")%></title>
  <link href="css/style.default.css" rel="stylesheet" />
  <link href="css/jquery.gritter.css" rel="stylesheet" />
  <link rel="stylesheet" href="css/colorpicker.css" />
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
<form class="form-horizontal form-bordered" runat="server" id="formulario">
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
      <h2><i class="fa fa-edit"></i> Vehiculos <span>Catalogos...</span></h2>
    </div>
    <div class="contentpanel">
          <div class="panel panel-default panel-alt widget-messaging">
          <div class="panel-heading">
              <div class="panel-btns">
                <a class="panel-edit"><button type="button" class="btn btn-primary btn-xs" id="BtnNuevoVehiculo"><i class="fa fa-plus-circle"></i> Nuevo</button></a>
              </div><!-- panel-btns -->
              <h3 class="panel-title">Vehiculos</h3>
            </div>
            <div class="panel-body">
                <table class="table table-hidaction table-hover mb30 TablaVehiculos" >
                    <thead>
                        <tr>
                            <th>Codigo</th>
                            <th>Placa</th>
                            <th>Kilometraje</th>
                            <th>Marca</th>
                            <th>Liea</th>
                            <th>Modelo</th>
                            <th>Tipo Vehiculo</th>
                            <th>Departamento</th>
                            <th></th>
                        </tr>
                    </thead>
                    <tbody>
                    </tbody>
                </table>
            </div><!-- panel-body -->
          </div><!-- panel -->
    </div><!-- contentpanel -->
  </div><!-- mainpanel -->
</section>
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
                    <input type="hidden" id="textMDId" name="textMDId" class="form-control" />
                    <input type="text" id="textMDCodigo" name="TxtMDCodigo" class="form-control" />
                </div>
                <label class="col-md-2">Placa:</label>
                <div class="col-md-4">
                    <input type="text" id="textMDPlaca"  name="TxtMDPlaca" class="form-control" />
                </div>
            </div>
            <div class="form-group">
                <label class="col-md-2">Kilometraje:</label>
                <div class="col-md-4">
                <input type="text" id="txtMDKilometraje"  name="TxtMDKilometraje" class="form-control" />
                </div>
               <label class="col-md-2">Marca:</label>
               <div class="col-md-4">
                <input type="text" id="txtMDMarca"  name="TxtMDmarca" class="form-control" />
                </div>
            </div>
            <div class="form-group">
                <label class="col-md-2">Linea:</label>
                 <div class="col-md-4">
                <input type="text" id="txtMDLinea"  name="TxtMDLinea" class="form-control" />
                </div>
                <label class="col-md-2">Modelo:</label>
                  <div class="col-md-4">
                <input type="text" id="txtMDModelo"  name="TxtMDModelo" class="form-control" />
                 </div>
            </div>
            <div class="form-group">
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
    </div>
  </div>
</div>
</form>
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
<script src="js/jquery.datatables.min.js"></script>
<script src="js/Script.js?v=1"></script>

<script>
    jQuery(document).ready(function () {
        $(".TablaVehiculos").dataTable();
        MostrarVehiculos(0);
        var IndexTr;
        $("#BtnNuevoVehiculo").click(function () {
            $("input:text").val("");
            $("#textMDId").val("");
            $('select').val(0).trigger("chosen:updated");
            $('.ModalEditarVehiculo').modal('toggle');
            $("#BtnGuardarV").show();
            $("#BtnEditarV").hide();
            $("#LblModificar").hide();
            $("#LblCrear").show();
        });
        $(".TablaVehiculos tbody").on("click", ".BtnEditarVehiculo", function () {
//            IndexTr = $(this).parent().parent().index();
//            $(".TableVehiculos").dataTable().fnDeleteRow(IndexTr);
            $("#BtnEditarV").show();
            $("#BtnGuardarV").hide();
            $("#LblModificar").show();
            $("#LblCrear").hide();
            var id = this.id;
            $("#CheckPool").toggles({ on: false, text: { on: 'SI', off: 'NO'} });
            //$("#CheckPool div").removeClass("active");
            $.ajax({
                type: "POST",
                url: "WebService.asmx/CatalogoVehiculos",
                data: "{ 'IdVehiculo': " + id + " }",
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
                        $('#DropTipoVehiculo').val(item.idtipovehiculo).trigger("chosen:updated");
                        $('#DropDepartamento').val(item.iddepartamento).trigger("chosen:updated");
                        $('#DropUsuario').val(item.usuario).trigger("chosen:updated");
                        $("#txtMDContable").val(item.contable);
                        $('#DropEstatus').val(item.status).trigger("chosen:updated");
                        $('#TxtCOEncargado').val(item.Correo).trigger("chosen:updated");
                        if (item.status) {
                            $('#DropEstatus').val(1).trigger("chosen:updated");
                        } else {
                            $('#DropEstatus').val(0).trigger("chosen:updated");
                        }
                        // $("#DropEstatus").val(item.status);
                        $("#txtMDCllantas").val(item.cllantas);
                        $("#txtMDCllantasR").val(item.repuesto);
                        if (item.pool) {
                            $("#CheckPool").toggles({ on: true });
                        }
                    });
                    $('.ModalEditarVehiculo').modal('toggle');
                },
                error: function (data) {
                    console.log(data);
                }
            });
        });
    });
    function MostrarVehiculos(id) {
        $.ajax({
            type: "POST",
            url: "WebService.asmx/CatalogoVehiculos",
            data: "{ 'IdVehiculo': "+id+" }",
            dataType: 'json',
            contentType: "application/json; charset=utf-8",
            success: function (data) {
                $.each(data.d, function (index, item) {
                    $(".TablaVehiculos").dataTable().fnAddData([
                        item.codigo,
                        item.placa,
                        item.kma,
                        item.marca,
                        item.linea,
                        item.modelo,
                        item.tipo,
                        item.departamento,
                        "<button type='button' id='" + item.Id + "' class='btn btn-default btn-xs BtnEditarVehiculo'  aria-label='Left Align'><i class='glyphicon glyphicon-edit EditarVehiculo'></i> Editar</button>"
                    ]);
                });
            },
            error: function (data) {
                console.log(data);
            }
        });
    }

    $(document).ready(function () {
        $("#BtnEditarV").click(function () {
            var tipo = $("#DropTipoVehiculo").val();
            var departamento = $("#DropDepartamento").val();     
            var usuario = $("#DropUsuario").val();
            var status = false;
            if ($("#DropEstatus").val() == 1) {
                status = true;
            }
            var pool = false;
            if ($("#CheckPool div:eq(0)").hasClass("active")) {
                pool = true;
            }
            $.ajax({
                type: "POST",
                url: "WebService.asmx/ActualizarVehiculo",
                data: "{'Id':" + $("#textMDId").val() + ",'codigo':'" + $("#textMDCodigo").val() + "', 'placa':'" + $("#textMDPlaca").val() + "', 'kma':'" + $("#txtMDKilometraje").val() + "', 'marca':'" + $("#txtMDMarca").val() + "', 'linea':'" + $("#txtMDLinea").val() + "', 'modelo':'" + $("#txtMDModelo").val() + "', 'tipo':'" + tipo + "', 'departamento':'" + departamento + "', 'contable':'" + $("#txtMDContable").val() + "', 'status':" + status + ", 'cllantas':" + $("#txtMDCllantas").val() + ", 'repuesto':" + $("#txtMDCllantasR").val() + ", 'pool':" + pool + ", 'Usuario':'" + usuario + "', 'CorreoEncargado':'" + $("#TxtCOEncargado").val() + "'}",
                dataType: 'json',
                contentType: "application/json; charset=utf-8",
                success: function (data) {
                    if (data.d[0].StrError == "0") {
                        $(".TablaVehiculos").dataTable().fnClearTable();
                        MostrarVehiculos(0);
                        $("input:text, input:hidden").val("");
                        jQuery.gritter.add({
                            title: 'Exito!',
                            text: 'La Operacion Se Ha Realizado Correctamente.',
                            class_name: 'growl-info',
                            image: 'images/screen.png',
                            sticky: false,
                            time: ''
                        });
                        $('.ModalEditarVehiculo').modal('toggle');
                    } else {
                        jQuery.gritter.add({
                            title: 'Se Ha Producido Un Error!',
                            text: data.d[0].StrError,
                            class_name: 'growl-danger',
                            image: 'images/screen.png',
                            sticky: false,
                            time: ''
                        });
                    }
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
        });

    });
    $(document).ready(function () {
        $("#BtnGuardarV").click(function () {
            var tipo = $("#DropTipoVehiculo").val();
            var departamento = $("#DropDepartamento").val();
            var status = false;
            if ($("#DropEstatus").val() == 1) {
                status = true;
            }
            var pool = false;
            if ($("#CheckPool div:eq(0)").hasClass("active")) {
                pool = true;
            }
            $.ajax({
                type: "POST",
                url: "WebService.asmx/GuardarVehiculo",
                data: "{'codigo':'" + $("#textMDCodigo").val() + "', 'placa':'" + $("#textMDPlaca").val() + "', 'kma':'" + $("#txtMDKilometraje").val() + "', 'marca':'" + $("#txtMDMarca").val() + "', 'linea':'" + $("#txtMDLinea").val() + "', 'modelo':'" + $("#txtMDModelo").val() + "', 'tipo':'" + tipo + "', 'departamento':'" + departamento + "', 'contable':'" + $("#txtMDContable").val() + "', 'status':" + status + ", 'cllantas':" + $("#txtMDCllantas").val() + ", 'repuesto':" + $("#txtMDCllantasR").val() + ", 'pool':" + pool + "}",
                dataType: 'json',
                contentType: "application/json; charset=utf-8",
                success: function (data) {
                    var NuevoId = data.d[0].IdVehiculo;
                    if (data.d[0].StrError == "0") {
                        $("input:text, #textMDId").val("");
                        jQuery.gritter.add({
                            title: 'Exito!',
                            text: 'La Operacion Se Ha Realizado Correctamente.',
                            class_name: 'growl-info',
                            image: 'images/screen.png',
                            sticky: false,
                            time: ''
                        });
                        $.ajax({
                            type: "POST",
                            url: "WebService.asmx/CatalogoVehiculos",
                            data: "{ 'IdVehiculo': " + NuevoId + " }",
                            dataType: 'json',
                            contentType: "application/json; charset=utf-8",
                            success: function (data) {
                                $.each(data.d, function (index, item) {
                                    $(".TablaVehiculos").dataTable().fnAddData([
                                        item.codigo,
                                        item.placa,
                                        item.kma,
                                        item.marca,
                                        item.linea,
                                        item.modelo,
                                        item.tipo,
                                        item.departamento,
                                        "<button type='button' id='" + item.Id + "' class='btn btn-default btn-xs BtnEditarVehiculo'  aria-label='Left Align'><i class='glyphicon glyphicon-edit EditarVehiculo'></i> Editar</button>"
                                    ]);
                                });
                            }
                        });
                        $('.ModalEditarVehiculo').modal('toggle');
                    } else {
                        jQuery.gritter.add({
                            title: 'Se Ha Producido Un Error!',
                            text: data.d[0].StrError,
                            class_name: 'growl-danger',
                            image: 'images/screen.png',
                            sticky: false,
                            time: ''
                        });
                    }
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
        });

    }); //JQuery


</script>
</body>
</html>