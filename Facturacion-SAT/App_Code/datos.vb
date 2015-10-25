Imports Microsoft.VisualBasic
Imports System.Data
Imports MySql.Data.MySqlClient
Public Class datos
    Inherits MyDB
    Private cn As New MySqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings("Conn").ConnectionString)
    Shared Function cadenaCon() As String
        Return System.Configuration.ConfigurationManager.ConnectionStrings("Conn").ConnectionString
    End Function
    Public Shared Function acceso(ByVal usuario As String, ByVal pagina As Integer) As Boolean
        Dim retorna As Boolean = False
        Try
            Dim str As String
            Dim Adaptador As New MySqlDataAdapter
            Dim TablaUsuario As New DataTable
            Using conexion As New MySqlConnection()
                conexion.ConnectionString = cadenaCon()
                conexion.Open()
                Dim comando As MySqlCommand
                comando = conexion.CreateCommand
                comando.CommandType = Data.CommandType.Text
                comando.Parameters.Add("@usuario", MySqlDbType.VarChar, 15).Value = usuario
                comando.Parameters.Add("@pagina", MySqlDbType.Int64, 6).Value = pagina
                str = "select userd.acceso from userw as userw inner join userd userd on userw.nrol=userd.idrol where userw.username=@usuario and userd.idacce=@pagina;"
                comando.CommandText = str
                Adaptador.SelectCommand = comando
                Adaptador.Fill(TablaUsuario)
                If TablaUsuario.Rows.Count > 0 Then
                    retorna = True
                    comando.Dispose()
                Else
                    retorna = False
                End If
            End Using
        Catch ex As Exception
            retorna = False
        End Try
        Return retorna
    End Function
    Public Shared Function addKey(ByVal Key As String) As String
        Return System.Configuration.ConfigurationManager.AppSettings(Key)
    End Function
    Sub infomenu(ByVal httpCookie As HttpCookie)
        'MsgBox(httpCookie.Item("Imagen"))
    End Sub
    Public Shared Sub CargarCombo(ByVal ComboBox As DropDownList, ByVal strsql As String)
        Dim conexion As New MySqlConnection()
        conexion.ConnectionString = cadenaCon()
        conexion.Open()
        Try
            Dim comando As New MySqlCommand(strsql, conexion)
            Dim da As New MySqlDataAdapter(comando)
            Dim ds As New DataSet

            da.Fill(ds)
            ComboBox.DataSource = ds.Tables(0)
            ComboBox.DataValueField = ds.Tables(0).Columns(0).Caption.ToString
            ComboBox.DataTextField = ds.Tables(0).Columns(1).Caption.ToString
            ComboBox.DataBind()
            ComboBox.SelectedIndex = -1
        Catch ex As MySqlException
            ' MessageBox.Show(ex.Message.ToString,"error", MessageBoxButtons.OK, MessageBoxIcon.Error)
        Finally
            conexion.Close()
        End Try
    End Sub
    Public Shared Sub CargarComboYears(ByVal Combobox As DropDownList)
        Dim newListItem As ListItem
        Dim i As Integer = Now.Year
        Dim yearAnterior As Integer = i - 10
        While i >= yearAnterior
            newListItem = New ListItem(i, i)
            Combobox.Items.Add(newListItem)
            i = i - 1
        End While
        Combobox.SelectedIndex = -1
    End Sub
    Public Shared Sub CargarComboMes(ByVal Combobox As DropDownList)
        Dim newListItem As ListItem
        newListItem = New ListItem("Enero", 1)
        Combobox.Items.Add(newListItem)
        newListItem = New ListItem("Febrero", 2)
        Combobox.Items.Add(newListItem)
        newListItem = New ListItem("Marzo", 3)
        Combobox.Items.Add(newListItem)
        newListItem = New ListItem("Abril", 4)
        Combobox.Items.Add(newListItem)
        newListItem = New ListItem("Mayo", 5)
        Combobox.Items.Add(newListItem)
        newListItem = New ListItem("Junio", 6)
        Combobox.Items.Add(newListItem)
        newListItem = New ListItem("Julio", 7)
        Combobox.Items.Add(newListItem)
        newListItem = New ListItem("Agosto", 8)
        Combobox.Items.Add(newListItem)
        newListItem = New ListItem("Septiembre", 9)
        Combobox.Items.Add(newListItem)
        newListItem = New ListItem("Octubre", 10)
        Combobox.Items.Add(newListItem)
        newListItem = New ListItem("Noviembre", 11)
        Combobox.Items.Add(newListItem)
        newListItem = New ListItem("Diciembre", 12)
        Combobox.Items.Add(newListItem)
        Combobox.SelectedValue = Now.Month
    End Sub
    Public Shared Function CargarDataTable(ByVal strsql As String) As DataTable
        'Dim conexion As OdbcConnection
        'conexion = New OdbcConnection()

        Dim conexion As MySqlConnection
        conexion = New MySqlConnection()
        conexion.ConnectionString = cadenaCon()
        conexion.Open()
        Dim ds As New DataTable
        Try
            Dim comando As New MySqlCommand(strsql, conexion)
            Dim da As New MySqlDataAdapter(comando)

            da.Fill(ds)
            Return ds
            'Catch ex As OdbcException
        Catch ex As MySqlException
            'MessageBox.Show(ex.Message.ToString, _
            '               "error", MessageBoxButtons.OK, _
            '              MessageBoxIcon.Error)
        Finally
            conexion.Close()
        End Try
        'Return ds
    End Function
    Public Shared Function ExisteDato(ByVal strSql As String) As Boolean
        'Dim conexion As OdbcConnection
        'Dim comando As OdbcCommand
        'Dim lector As OdbcDataReader
        'conexion = New OdbcConnection()
        Dim conexion As MySqlConnection
        Dim comando As MySqlCommand
        Dim lector As MySqlDataReader
        conexion = New MySqlConnection()
        Dim retorna As Boolean = False
        conexion.ConnectionString = cadenaCon()
        conexion.Open()
        Try
            'comando = New OdbcCommand(strSql, conexion)
            comando = New MySqlCommand(strSql, conexion)

            lector = comando.ExecuteReader
            lector.Read()
            If lector.HasRows = False Then
                retorna = False
            Else
                retorna = True
            End If
            conexion.Close()
            'Catch ex As OdbcException
        Catch ex As MySqlException
            'MessageBox.Show(ex.Message.ToString, _
            '               "error", MessageBoxButtons.OK, _
            '              MessageBoxIcon.Error)
            retorna = False
            conexion.Close()
        Finally
            conexion.Close()
        End Try
        Return retorna
    End Function
    Public Sub cargar_Grid(ByVal Datagridview As GridView, ByVal strsql As String)
        cn.Open()
        Try
            'Dim comando As New OdbcCommand(strsql, conexion)
            'Dim da As New OdbcDataAdapter(comando)
            Dim comando As New MySqlCommand(strsql, cn)
            Dim da As New MySqlDataAdapter(comando)

            Dim ds As New DataSet
            da.Fill(ds)
            Datagridview.DataSource = ds.Tables(0)
            Datagridview.DataBind()
            'Catch ex As OdbcException
        Catch ex As MySqlException

            'MsgBox(ex)
        Finally
            cn.Close()
        End Try
    End Sub
    Public Function Datos(ByVal Cons As String)
        cn.Open()
        Try
            Dim cmd As New MySqlCommand(Cons, cn)
            Dim da As New MySqlDataAdapter(cmd)
            Dim dt As New DataTable
            da.Fill(dt)
            Return dt
        Catch ex As Exception
            'MsgBox(ex.Message)
        Finally
            cn.Close()
        End Try
        Return 0
    End Function

    Public Function cargar_datatable(ByVal strsql As String) As DataTable

        cn.Open()
        Dim ds As New DataTable
        Try
            Dim comando As New MySqlCommand(strsql, cn)
            Dim da As New MySqlDataAdapter(comando)
            da.Fill(ds)
        Catch ex As MySqlException
        Finally
            cn.Close()
        End Try
        Return ds
    End Function

    Public Shared Function EjecutaTransaccion1(ByVal str1 As String) As Boolean
        Dim conexion As MySqlConnection
        conexion = New MySqlConnection()
        conexion.ConnectionString = cadenaCon()
        conexion.Open()
        Dim comando As New MySqlCommand
        Dim transaccion As MySqlTransaction
        transaccion = conexion.BeginTransaction
        comando.Connection = conexion
        comando.Transaction = transaccion
        Try
            comando.CommandText = str1
            comando.ExecuteNonQuery()
            transaccion.Commit()
            EjecutaTransaccion1 = True
        Catch ex As Exception
            transaccion.Rollback()
            EjecutaTransaccion1 = False
        Finally
            conexion.Close()
        End Try
    End Function

    Public Shared Function EjecutaTransaccion(ByVal str1 As String, ByVal str2 As String) As Boolean
        'Dim conexion As OdbcConnection
        'Dim comando As OdbcCommand
        Dim conexion As MySqlConnection
        conexion = New MySqlConnection()
        conexion.ConnectionString = cadenaCon()
        conexion.Open()
        Dim comando As New MySqlCommand
        Dim transaccion As MySqlTransaction
        transaccion = conexion.BeginTransaction
        comando.Connection = conexion
        comando.Transaction = transaccion

        Try
            'ejecuto primer comando sql
            comando.CommandText = str1
            comando.ExecuteNonQuery()
            'ejecuto segundo comando sql
            comando.CommandText = str2
            comando.ExecuteNonQuery()
            transaccion.Commit()
            EjecutaTransaccion = True
        Catch ex As Exception
            'MsgBox(ex.Message.ToString)
            transaccion.Rollback()
            EjecutaTransaccion = False
        Finally
            conexion.Close()
        End Try
    End Function
    Public Shared Function StringAleatoreo(ByVal cantidad As Integer) As String
        Dim result As String = ""
        Dim i As Integer = 1
        Dim rnd As New Random
        While i <= cantidad
            Dim tipo As Integer
            tipo = rnd.Next(1, 2)
            If tipo = 1 Then
                result = result & rnd.Next(0, 9).ToString
            Else
                Dim letra = rnd.Next(1, 26)
                Select Case letra
                    Case "1" : result = result & "a"
                    Case "2" : result = result & "b"
                    Case "3" : result = result & "c"
                    Case "4" : result = result & "d"
                    Case "5" : result = result & "e"
                    Case "6" : result = result & "f"
                    Case "7" : result = result & "g"
                    Case "8" : result = result & "h"
                    Case "9" : result = result & "i"
                    Case "10" : result = result & "j"
                    Case "11" : result = result & "k"
                    Case "12" : result = result & "l"
                    Case "13" : result = result & "m"
                    Case "14" : result = result & "n"
                    Case "15" : result = result & "o"
                    Case "16" : result = result & "p"
                    Case "17" : result = result & "q"
                    Case "18" : result = result & "r"
                    Case "19" : result = result & "s"
                    Case "20" : result = result & "t"
                    Case "21" : result = result & "u"
                    Case "22" : result = result & "v"
                    Case "23" : result = result & "w"
                    Case "24" : result = result & "x"
                    Case "25" : result = result & "y"
                    Case "26" : result = result & "z"
                End Select
            End If
            i = i + 1
        End While
        Return result
    End Function
    Public Function validaCorreo(ByVal correo As String) As Boolean
        Return Regex.IsMatch(correo, "^(?("")("".+?""@)|(([0-9a-zA-Z]((\.(?!\.))|[-!#\$%&'\*\+/=\?\^`\{\}\|~\w])*)(?<=[0-9a-zA-Z])@))" + "(?(\[)(\[(\d{1,3}\.){3}\d{1,3}\])|(([0-9a-zA-Z][-\w]*[0-9a-zA-Z]\.)+[a-zA-Z]{2,6}))$")
    End Function
    Public Shared Function EstadoReservacion(ByVal estado As Integer) As String
        Dim result As String = ""
        Select Case estado
            Case "0" : result = result & "Solicitud"
            Case "1" : result = result & "Aprobado"
            Case "2" : result = result & "Cancelado"
            Case "3" : result = result & "Entregado"
            Case "4" : result = result & "Devuelto"
        End Select
        Return result
    End Function
    Public Shared Sub CargarComboMas(ByVal ComboBox As DropDownList, ByVal strsql As String, ByVal extra As String)
        Dim conexion As New MySqlConnection()
        conexion.ConnectionString = cadenaCon()
        conexion.Open()
        Try
            Dim comando As New MySqlCommand(strsql, conexion)
            Dim da As New MySqlDataAdapter(comando)
            Dim ds As New DataSet

            da.Fill(ds)
            ComboBox.DataSource = ds.Tables(0)
            ComboBox.DataValueField = ds.Tables(0).Columns(0).Caption.ToString
            ComboBox.DataTextField = ds.Tables(0).Columns(1).Caption.ToString
            ComboBox.DataBind()
            Dim newListItem As ListItem
            newListItem = New ListItem("TODOS", extra)
            ComboBox.Items.Insert(0, newListItem)
            ComboBox.SelectedIndex = -1
        Catch ex As MySqlException
            ' MessageBox.Show(ex.Message.ToString,"error", MessageBoxButtons.OK, MessageBoxIcon.Error)
        Finally
            conexion.Close()
        End Try
    End Sub
    Public Shared Sub CargarComboMasNA(ByVal ComboBox As DropDownList, ByVal strsql As String)
        Dim conexion As New MySqlConnection()
        conexion.ConnectionString = cadenaCon()
        conexion.Open()
        Try
            Dim comando As New MySqlCommand(strsql, conexion)
            Dim da As New MySqlDataAdapter(comando)
            Dim ds As New DataSet

            da.Fill(ds)
            ComboBox.DataSource = ds.Tables(0)
            ComboBox.DataValueField = ds.Tables(0).Columns(0).Caption.ToString
            ComboBox.DataTextField = ds.Tables(0).Columns(1).Caption.ToString
            ComboBox.DataBind()
            Dim newListItem As ListItem
            newListItem = New ListItem("N/A", "N/A")
            ComboBox.Items.Insert(0, newListItem)
            ComboBox.SelectedIndex = -1
        Catch ex As MySqlException
            ' MessageBox.Show(ex.Message.ToString,"error", MessageBoxButtons.OK, MessageBoxIcon.Error)
        Finally
            conexion.Close()
        End Try
    End Sub
    Public Shared Sub CargarComboDepartamentos(ByVal ComboBox As DropDownList)
        Dim conexion As New MySqlConnection()
        conexion.ConnectionString = cadenaCon()
        conexion.Open()
        Try
            Dim comando As New MySqlCommand("SELECT id,descripcion FROM departamentos;", conexion)
            Dim da As New MySqlDataAdapter(comando)
            Dim ds As New DataSet

            da.Fill(ds)
            ComboBox.DataSource = ds.Tables(0)
            ComboBox.DataValueField = ds.Tables(0).Columns(0).Caption.ToString
            ComboBox.DataTextField = ds.Tables(0).Columns(1).Caption.ToString
            ComboBox.DataBind()
            ComboBox.SelectedIndex = -1
        Catch ex As MySqlException
            ' MessageBox.Show(ex.Message.ToString,"error", MessageBoxButtons.OK, MessageBoxIcon.Error)
        Finally
            conexion.Close()
        End Try
    End Sub
    Public Shared Sub CargarComboTipoVehiculo(ByVal ComboBox As DropDownList)
        Dim conexion As New MySqlConnection()
        conexion.ConnectionString = cadenaCon()
        conexion.Open()
        Try
            Dim comando As New MySqlCommand("select id_tipo_vehiculo, tipo_vehiculo from tipo_vehiculo;", conexion)
            Dim da As New MySqlDataAdapter(comando)
            Dim ds As New DataSet
            da.Fill(ds)
            ComboBox.DataSource = ds.Tables(0)
            ComboBox.DataValueField = ds.Tables(0).Columns(0).Caption.ToString
            ComboBox.DataTextField = ds.Tables(0).Columns(1).Caption.ToString
            ComboBox.DataBind()
            ComboBox.SelectedIndex = -1
        Catch ex As MySqlException
            ' MessageBox.Show(ex.Message.ToString,"error", MessageBoxButtons.OK, MessageBoxIcon.Error)
        Finally
            conexion.Close()
        End Try
    End Sub



    Public Shared Sub CargarComboUsuario(ByVal ComboBox As DropDownList)
        Dim conexion As New MySqlConnection()
        conexion.ConnectionString = cadenaCon()
        conexion.Open()
        Try
            Dim comando As New MySqlCommand("select IdEmpleado, nombre from personal;", conexion)
            Dim da As New MySqlDataAdapter(comando)
            Dim ds As New DataSet

            da.Fill(ds)
            ComboBox.DataSource = ds.Tables(0)
            ComboBox.DataValueField = ds.Tables(0).Columns(0).Caption.ToString
            ComboBox.DataTextField = ds.Tables(0).Columns(1).Caption.ToString
            ComboBox.DataBind()
            ComboBox.SelectedIndex = -1
        Catch ex As MySqlException
            ' MessageBox.Show(ex.Message.ToString,"error", MessageBoxButtons.OK, MessageBoxIcon.Error)
        Finally
            conexion.Close()
        End Try
    End Sub
End Class
