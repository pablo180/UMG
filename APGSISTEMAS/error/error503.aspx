<%@ Page Language="VB" AutoEventWireup="false" CodeFile="error503.aspx.vb" Inherits="error_error503" %>

<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0">
  <meta name="description" content="">
  <meta name="author" content="">
  <link rel="shortcut icon" href="images/favicon.png" type="image/png">

  <title>Error 503 | Monitoreo</title>

  <link href="css/style.default.css" rel="stylesheet">

  <!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
  <!--[if lt IE 9]>
  <script src="js/html5shiv.js"></script>
  <script src="js/respond.min.js"></script>
  <![endif]-->
</head>

<body class="notfound">

<!-- Preloader -->
<div id="preloader">
    <div id="status"><i class="fa fa-spinner fa-spin"></i></div>
</div>

<section>
  
  <div class="notfoundpanel">
    <h1>503!</h1>
    <h3>Servicio No Disponible!</h3>
    <h4>Tu proveedor de servicios Internet o la conexión Internet de la compañía se ha caído. Por Favor Intentalo Más Tarde. <br />Regresar a Pagina Principal:</h4>
    <form action="search-results.html">
        <a class="btn btn-success" href="Dashboard">Regresar</a>
    </form>
  </div><!-- notfoundpanel -->
  
</section>


<script src="js/jquery-1.10.2.min.js"></script>
<script src="js/jquery-migrate-1.2.1.min.js"></script>
<script src="js/bootstrap.min.js"></script>
<script src="js/modernizr.min.js"></script>
<script src="js/retina.min.js"></script>

<script src="js/custom.js"></script>

</body>
</html>

