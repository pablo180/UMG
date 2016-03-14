$(document).ready(function () {
    if (/Android|webOS|iPhone|iPad|iPod|BlackBerry|IEMobile|Opera Mini/i.test(navigator.userAgent)) {
        jQuery.cookie('sticky-leftpanel', true, { path: '/' });
        jQuery('body').addClass('stickyheader');
        jQuery('.leftpanel').addClass('sticky-leftpanel');
    } else {
        jQuery.removeCookie('sticky-leftpanel', { path: '/' });
        if (!jQuery.cookie('sticky-header'))
            jQuery('body').removeClass('stickyheader');
        jQuery('.leftpanel').removeClass('sticky-leftpanel');
    }
    jQuery("select").chosen({ 'width': '100%', 'white-space': 'nowrap' });
    $("#TxtProducto").autocomplete({
        source: function (request, response) {
            $.ajax({
                type: "POST",
                url: "WebService.asmx/BuscarProducto",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                data: "{ producto: '" + request.term + "' }",
                success: function (data) {
                    var producto = new Array;
                    $.each(data.d, function (i, item) {
                        producto.push(item.Producto)
                    })
                    response(producto);
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
        },
        change: function (event, ui) {
        },
        minLength: 3,
        maxRows: 15,
        delay: 0
    });
    $("#BtnAgregarProducto").click(function () {
        if ($("#DropProducto").val() != "" && $.isNumeric($("#TxtCantidad").val()) && $.isNumeric($("#TxtPrecio").val())) {
            // var codigo = $("#TxtProducto").val().split(",");
            var total = $("#TxtCantidad").val() * $("#TxtPrecio").val();
        
            $(".FacturaDetalle tbody").append("<tr><td>" + $("#DropProducto").val() + "</td><td>" + $("#DropProducto option:selected").html() + "</td><td>" + $("#TxtCantidad").val() + "</td><td>" + $("#TxtPrecio").val() + "</td><td>" + total + "</td><td class='table-action'><a class='delete-row baja'><i class='fa fa-trash-o'></i></a></td></tr>");
        } else {
            jQuery.gritter.add({
                title: 'Se Ha Producido Un Error!',
                text: 'Datos Ingresados Incorrectos',
                class_name: 'growl-danger',
                image: 'images/screen.png',
                sticky: false,
                time: ''
            });
        }
    });
    $(".baja").live('click', function () {
        $(this).parent().parent().remove();
    });
    $("#TxtNitProveedor").blur(function () {
        if ($(this).val() != "") {
            $.ajax({
                type: "POST",
                url: "WebService.asmx/BuscarProveedorNit",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                data: "{nit:'" + $(this).val() + "'}",
                success: function (data) {
                    if (data.d.length != 0) {
                        $.each(data.d, function (index, item) {
                            if (item.Nombre != "") {
                                $("#TxtNombreProveedor").prop('disabled', true);
                                $("#TxtNombreProveedor").val(item.Nombre);
                            } else {
                                $("#TxtNombreProveedor").val("");
                                $("#TxtNombreProveedor").prop('disabled', false);
                                $("#TxtNombreProveedor").focus();
                            }
                        });
                    } else {
                        $("#TxtNombreProveedor").val("");
                        $("#TxtNombreProveedor").prop('disabled', false);
                        $("#TxtNombreProveedor").focus();
                    }
                }
            });
        }
    });
    $("#BtnGuardarFacturaViaticos").click(function (event) {
        var detalle = new Array()
        $(".FacturaDetalle tbody tr").each(function () {
            detalle.push({ codigo: $(this).find("td:eq(0)").html(), descripcion: $(this).find("td:eq(1)").html(), cantidad: $(this).find("td:eq(2)").html(), precioUnidad: $(this).find("td:eq(3)").html(), total: $(this).find("td:eq(4)").html() });
        });
        $.ajax({
            type: "POST",
            url: "WebService.asmx/GuardarFacturaViaticos",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            data: "{'FechaFactura':'" + $("#TxtFecha").val() + "', 'NitProveedor':'" + $("#TxtNitProveedor").val() + "', 'NombreProveedor': '" + $("#TxtNombreProveedor").val() + "', 'SerieFactura': '" + $("#TxtSerieFactura").val() + "', 'NumeroFactura':'" + $("#TxNumeroFactura").val() + "', 'Observacion': '" + $("#TxtObservacion").val() + "', 'Detalle':" + JSON.stringify(detalle) + "}",
            success: function (data) {
                $.each(data.d, function (index, item) {
                    if (item.StrError == "0") {
                        jQuery.gritter.add({
                            title: 'Exito!',
                            text: 'El Ingreso se ha realizado correctamente.',
                            class_name: 'growl-success',
                            image: 'images/screen.png',
                            sticky: false,
                            time: ''
                        });
                        $("select").trigger('chosen:updated');
                        $("input:text").val("");
                        $("#ChkOrdenTrabajo").attr('checked', false);
                        $("#TxtFecha").mask('99-99-9999').datepicker("setDate", new Date());
                        $("#TxtOrdenTrabajo").attr('disabled', true);
                        $(".FacturaDetalle tbody").html("");
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
            }
        });
    });
    $("#ChkOrdenTrabajo").change(function () {
        if ($(this).is(":checked")) {
            $("#TxtOrdenTrabajo").attr("disabled", false);
            $("#TxtOrdenTrabajo").focus();
        } else {
            $("#TxtOrdenTrabajo").attr("disabled", true);
            $("#TxtOrdenTrabajo").val("");
        }
    });
});
function validaCorreo(correo) {
    var filter = /[\w-\.]{3,}@([\w-]{2,}\.)*([\w-]{2,}\.)[\w-]{2,4}/;
    if (filter.test(correo))
        return true;
    else
        return false;
}
function ValidarFechas(FechaInicial, FechaFinal) {
        valuesStart = fechaInicial.split("-");
        valuesEnd = fechaFinal.split("-");
        // Verificamos que la fecha no sea posterior a la actual
        var dateStart = new Date(valuesStart[2], (valuesStart[1] - 1), valuesStart[0]);
        var dateEnd = new Date(valuesEnd[2], (valuesEnd[1] - 1), valuesEnd[0]);
        if (dateStart >= dateEnd) {
            return false;
        }
        return true;
}


function FcrearPDF(serie) {
    $.ajax({
        type: "POST",
        url: "WebService.asmx/crearLiquidacionPDF",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        data: "{factura: '" + serie + "'}",
        async: false,
        success: function (data) {
            if (data.d) {
                $.fancybox({
                    'autoScale': false,
                    'transitionIn': 'none',
                    'transitionOut': 'none',
                    'width': '70%',
                    'height': '100%',
                    'type': 'iframe',
                    'href': 'reporte/ReporteFactura.pdf'
                });
            } else {
                $.gritter.add({
                    title: 'Se Ha Producido Un Error!',
                    text: 'No se puede crear el reporte',
                    class_name: 'growl-danger',
                    image: 'images/screen.png',
                    sticky: false,
                    time: ''
                });
            }
        },
        error: function (data) {
            $.gritter.add({
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