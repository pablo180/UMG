<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Clientes.aspx.vb" Inherits="privado_Clientes" %>

<!DOCTYPE html>

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
      <h2><i class="fa fa-edit"></i> Clientes <span>Catalogos...</span></h2>
    </div>
    <div class="contentpanel">
          <div class="panel panel-default panel-alt widget-messaging">
          <div class="panel-heading">
              <div class="panel-btns">
                <a class="panel-edit"><button type="button" class="btn btn-primary btn-xs" id="BtnNuevoCliente"><i class="fa fa-plus-circle"></i> Nuevo</button></a>
              </div><!-- panel-btns -->
              <h3 class="panel-title">Clientes</h3>
            </div>
            <div class="panel-body">
                <table class="table table-hidaction table-hover mb30 TablaClientes" >
                    <thead>
                        <tr>
                            <th>Codigo</th>
                            <th>Nombre</th>
                            <th>Nit</th>
                            <th>Telefono</th>
                            <th>Celular</th>
                            <th>Direccion</th>
                            <th>Correo</th>
                            <th>Estado</th>
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
            <h4 class="modal-title"><span style="display:none" id="LblModificar">Modificaion</span><span style="display:none" id="LblCrear">Creacion</span> de  Cliente a: <i><label id="Label1"></label></i></h4>
        </div>
        <div class="modal-body">
        <input type="hidden" id="Hidden1" />
        
            <div class="form-group">
                     <label class="col-md-2">Nombre:</label>
                <div class="col-md-4">
                    <input type="text" id="textMDNombre"  name="textMDNombre" class="form-control" />
                    <input type="hidden" id="textMDId" name="textMDId" class="form-control" />

                </div>
                <label class="col-md-2">Nit:</label>
                <div class="col-md-4">
                <input type="text" id="txtMDNit"  name="txtMDNit" class="form-control" />
                </div>
            
            </div>
            <div class="form-group">
                <label class="col-md-2">Telefono:</label>
                 <div class="col-md-4">
                <input type="text" id="txtMDTelefono"  name="txtMDTelefono" class="form-control" />
                </div>
                <label class="col-md-2">Direccion:</label>
                  <div class="col-md-4">
                <input type="text" id="txtMDDireccion"  name="txtMDDireccion" class="form-control" />
                 </div>
            </div>
            <div class="form-group">
                <label class="col-md-2">Correo:</label>
                <div class="col-md-4">
                  <input type="text" id="txtCorreo"  name="txtCorreo" class="form-control" />
                </div>
                <label class="col-md-2">Celular:</label>
                <div class="col-md-4">
                            <input type="text" id="txtCelular"  name="txtCelular" class="form-control" />
                </div>
            </div>
             <div class="form-group">
              
                <label class="col-md-2">Estatus:</label>
                  <div class="col-md-4">
                     <select id="DropEstatus" name="DropEstatus" style="width:100%;">
                        <option value="1">Alta</option>
                        <option value="0">Baja</option>
                     </select>
                 </div>
            </div>
  
           
            <div class="form-group">
                <div class="col-md-4">
                </div>
                 <div class="col-md-6">
                </div>
                <div class="col-md-2">
                    <div class="btn-demo">
                        <input type="button" id="BtnEditarC" class="btn btn-primary" value="Guardar" />
                        <input type="button" id="BtnGuardarC" class="btn btn-primary" value="Guardar" />
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
<script src="js/funciones/Cliente.js?v=1"></script>



</body>
</html>