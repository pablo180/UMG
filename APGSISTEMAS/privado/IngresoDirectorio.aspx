<%@ Page Language="VB" AutoEventWireup="false" CodeFile="IngresoDirectorio.aspx.vb" Inherits="privado_IngresoDirectorio" %>

<html lang="es">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">
    <link rel="shortcut icon" href="images/favicon.png" type="image/png">
    <title>Ingreso Directorio | <%=datos.addKey("NameProject")%></title>
    <link href="css/style.default.css" rel="stylesheet" />
    <link href="css/jquery.gritter.css" rel="stylesheet" />
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
    <form class="form-horizontal form-bordered" runat="server" id="formulario">
        <section>
            <div class="leftpanel">
                <div class="logopanel">
                    <h1><span>[</span> <%=datos.addKey("NameProject")%> <span>]</span></h1>
                </div>
                <!-- logopanel -->
                <div class="leftpanelinner">
                    <!-- This is only visible to small devices -->
                    <!-- #include file="usuario.html"-->

                    <h5 class="sidebartitle">Men&uacute;</h5>
                    <!--#include file="menu.html" -->
                </div>
                <!-- leftpanelinner -->
            </div>
            <!-- leftpanel -->
            <div class="mainpanel">
                <div class="headerbar">
                    <a class="menutoggle"><i class="fa fa-bars"></i></a>
                    <!-- #INCLUDE FILE="usuariomenu.html" -->
                </div>
                <!-- headerbar -->
                <div class="pageheader">
                    <h2><i class="fa fa-edit"></i>Ingreso Directorio <span>Ingresos...</span></h2>
                </div>
                <div class="contentpanel">
                    <div class="panel panel-default">
                        <div class="panel-body panel-body-nopadding">
                                 <div class="form-group">
                                <label class="col-sm-2 control-label">Nombre Compañia</label>
                                <div class="col-sm-4">
                                    <input type="text" placeholder="Ej. A" class="form-control" id="TxtNombreCompañia" />
                                </div>
                                <label class="col-sm-2 control-label">Dirección</label>
                                <div class="col-sm-4">
                                    <input type="text" placeholder="Ej. 578" class="form-control" id="TxtDireccion" />
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-sm-2 control-label">Departamento</label>
                                <div class="col-sm-4">
                                    <select id="DropDepartamento" class="form-control"></select>
                                </div>
                                <label class="col-sm-2 control-label">Municipio</label>
                                <div class="col-sm-4">
                                    <select id="DropMunicipios" class="form-control"></select>
                                </div>
                            </div>
                       
                            <div class="form-group">
                                <label class="col-sm-2 control-label">Telefono</label>
                                <div class="col-sm-4">
                                    <div class="panel panel-default">
                                        
                                  <input type="text" placeholder="Ej. 578" class="form-control" id="TxtTelefono" />
                                       
                                    </div>
                                </div>
                                <label class="col-sm-2 control-label">Nombre Contacto</label>
                                <div class="col-sm-4">
                                    <input type="text" placeholder="" class="form-control" id="TxtNombreContacto" />
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-sm-2 control-label">Observaciones</label>
                                <div class="col-sm-4">
                                    <input type="text" placeholder="" class="form-control" id="TxtObservacion" />
                                </div>

                            </div>

                        

                        </div>
                        <!-- panel-body -->
                  
                        <!-- panel-footer -->
                    </div>
                    <!-- panel -->
                    <div class="row">
                        <div class="col-md-12">
                            <div class="table-responsive">

                                <div class="panel panel-default">

                                    <div class="form-group">
                                        <div class="row">
                                            <div class="col-sm-1 col-sm-offset-9">
                                                <input type="button" class="btn btn-primary" id="BtnGuardarFacturaViaticos" value="Guardar" />
                                            </div>
                                            <div class="col-sm-1">
                                                <button class="btn btn-danger" id="BtnCancelar">Cancelar</button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <!-- table-responsive -->
                        </div>
                        <!-- col-md-12 -->
                    </div>
                    <!-- row -->
                </div>
                <!-- contentpanel -->
            </div>
            <!-- mainpanel -->
        </section>
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
    <%--<script src="js/Script.js"></script>--%>


    
     <script src="js/jquery.datatables.min.js"></script>
    <%--<script src="js/Script.js?v=1"></script>--%>
    <script src="js/funciones/IngresoDirectorio.js?v=1"></script>
