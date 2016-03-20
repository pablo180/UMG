$(document).ready(function () {
    LlenarDepartamentos();

});

function LlenarDepartamentos() {
    $.ajax({
        type: "POST",
        url: "wsdepartamentomunicipio.asmx/Departamentos",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (msg) {
            $.each(msg.d, function (index, item) {
                $("#DropDepartamento").trigger('chosen:updated').append("<option value='" + item.IdDepartamento + "'>" + item.Nombre + "</option>");
            });
            //$("#DropDepartamento, #DropDepartamento3, #DropDepartamentoOrigen4, #DropDepartamentoDestino4").select2().select2("val");
            LlenarMunicipio($("#DropDepartamento").val());
        },
        error: function (msg) {
            Error(msg.responseText);
        }
    });
    jQuery("select").chosen({ 'width': '100%', 'white-space': 'nowrap' });
}

function LlenarMunicipio(IdDepartamento) {
    $.ajax({
        type: "POST",
        url: "wsdepartamentomunicipio.asmx/Municipios",
        contentType: "application/json; charset=utf-8",
        data: "{IdDepartamento:" + IdDepartamento + "}",
        dataType: "json",
        success: function (msg) {
            $("#DropMunicipios").html("");
            $.each(msg.d, function (index, item) {
                $("#DropMunicipios").trigger('chosen:updated').append("<option value='" + item.IdMunicipio + "'>" + item.Nombre + "</option>");
            });
            //$("#DropMunicipios").select2().select2("val");
        },
        error: function (msg) {
            msgerror(msg.responseText);
        }
    });
}

$("#DropDepartamento").bind("change blur", function () {
    LlenarMunicipio($(this).val());
});

  $("#BtnGuardarDirectorio").click(function () {
   console.log("Si entra")
        $.ajax({
            type: "POST",
            url: "wsIngresoDirectorio.asmx/GuardarDirectorio",
            data: "{'NombreCompania':'" + $("#TxtNombreCompañia").val() + "', 'Direccion':'" + $("#TxtDireccion").val() + "', 'Departamento':'" + $("#DropDepartamento").val() + "', 'Municipio':'" + $("#DropMunicipios").val() + "', 'Telefono':'" + $("#TxtTelefono").val() + "', 'NombreContacto':'" + $("#TxtNombreContacto").val() + "', 'Observacion':'" + $("#TxtObservacion").val() + "', 'Correo':'" + $("#TxtCorreo").val() + "'}",
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