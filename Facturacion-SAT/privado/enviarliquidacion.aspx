<%@ Page Language="VB" AutoEventWireup="false" CodeFile="enviarliquidacion.aspx.vb" Inherits="privado_enviarliquidacion" %>

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
      <h2><i class="fa fa-edit"></i> Liquidación Gastos <span>Envio...</span></h2>
    </div>
    
    <div class="contentpanel">
      <form class="form-horizontal form-bordered" runat="server" id="formulario">
      <div class="panel panel-default">
        <div class="panel-body panel-body-nopadding">
          
          
            <div class="form-group">
              <label class="col-sm-2 control-label">Número</label>
              <div class="col-sm-4">
                <input type="text" class="form-control" id="TxtSerieFactura" readonly="readonly" runat="server"/>
              </div>
              <label class="col-sm-2 control-label">Fecha</label>
              <div class="col-sm-4">
                <div class="panel panel-default">
                    <div class="input-group">
                        <input type="text" class="form-control" placeholder="dd-mm-yyyy" id="TxtFecha" readonly="readonly" runat="server"/>
                        <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                    </div>
                </div>
              </div>
            </div>
                  
        </div><!-- panel-body -->
<%--        <div class="panel-footer">
		  </div><!-- panel-footer -->--%>
      </div><!-- panel -->
        <div class="row">
        <div class="col-md-12">
          <div class="table-responsive">
          <div>
             <asp:GridView ID="Detalle" runat="server" AutoGenerateColumns="False" DataKeyNames="fecha" CssClass="grids table" Width ="100%">
            <Columns>
               <asp:BoundField DataField="fecha" HeaderText="Fecha" SortExpression="id_Deta_Cotizacion" ItemStyle-HorizontalAlign ="Center"  />
               <asp:BoundField DataField="serie" HeaderText="Serie" SortExpression="Id_Art" ItemStyle-HorizontalAlign ="Center" />
               <asp:BoundField DataField="nofac" HeaderText="Numero" SortExpression="Cant_Deta_Cotizacion" ItemStyle-HorizontalAlign ="Center"/>
               <asp:BoundField DataField="nombre" HeaderText="Proveedor" SortExpression="nom_art" ItemStyle-HorizontalAlign ="left"/>
               <asp:BoundField DataField="provedor" HeaderText="Nit" SortExpression="Precio_Deta_Cotizacion" ItemStyle-HorizontalAlign ="Center"/>              
               <asp:BoundField DataField="Valor" HeaderText="Total" SortExpression="Precio_Deta_Cotizacion" ItemStyle-HorizontalAlign ="Right" />              
               </Columns>
            </asp:GridView>
            </div>
                <div class="col-sm-1">
				  <br/>
                </div>
            </div>
            </div>
            </div>
<%--            </form>--%>
          <div class="panel panel-default">
          
<%--          <form class="form-horizontal form-bordered">--%>
            <div class="form-group">
              <div class="row">
                <div class="col-sm-3">
				  <label>Anticipos</label>
                    <%--<div class="col-sm-4">--%>
                       <input type="text" placeholder=""  id="txtamtocipos" runat="server" onkeyup="return txtamtocipos_onkeyup()"/>
                    <%--</div>--%>
				</div>
                <div class="col-sm-3">
				  <label >Total Gastos</label>
                    <%--<div class="col-sm-4">--%>
                       <input type="text" placeholder="" id="txttotalgastos" runat="server" readonly />
                       <%--<asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>--%>
                    <%--</div>--%>
				</div>
                <div class="col-sm-3">
				  <label >Saldo a Cargo</label>
                    <%--<div class="col-sm-4">--%>
                       <input type="text" placeholder="" id="Text3" runat="server" readonly />
                    <%--</div>--%>
				</div> 
                <div class="col-sm-3">
				  <label >Saldo a Favor</label>
                    <%--<div class="col-sm-4">--%>
                       <input type="text" placeholder="" id="txtsaldofavor" runat="server" readonly />
                    <%--</div>--%>
				</div>

				<div class="col-sm-1 col-sm-offset-9">
				  <button type="button" class="btn btn-primary" id="btnenviar" runat="server">Enviar</button>
				</div>
                <div class="col-sm-1">
				  <button class="btn btn-danger" id="BtnCancelar" runat="server">Cancelar</button>
				</div>
                <div class="col-sm-1">
				  <br/>
				</div>
			 </div>
            </div>
            </div>           
            </form>
            
          </div><!-- table-responsive -->
        <%--</div>--%><!-- col-md-12 -->
      <%--</div>--%><!-- row -->
    </div><!-- contentpanel -->
  <%--</div>--%><!-- mainpanel -->
</section>
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
<script type="text/javascript" src="js/Script.js"></script>
<script type="text/javascript">

    function txtamtocipos_onkeyup() {

        var anticipo = jQuery('#txtamtocipos').val();
        var gastos = jQuery('#txttotalgastos').val().replace(',', '');
        var saldo = (anticipo - gastos);

        if (saldo > 0) {
            jQuery('#Text3').val(saldo.toFixed(2));
            jQuery('#txtsaldofavor').val("0.00");
        };

        if (saldo < 0) {
            saldo = (saldo * -1)
            jQuery('#txtsaldofavor').val(saldo.toFixed(2));
            jQuery('#Text3').val("0.00");
        };

        if (saldo == 0) {
            jQuery('#Text3').val("0.00");
            jQuery('#txtsaldofavor').val("0.00");
        };
    }
</script>
</body>
</html>