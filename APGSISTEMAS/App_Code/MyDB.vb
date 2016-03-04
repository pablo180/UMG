Imports Microsoft.VisualBasic
Imports System.Data
Imports MySql.Data.MySqlClient
Public Class MyDB
    Private cn As New MySqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings("Conn").ConnectionString)
    Shared Function cadenaCon() As String
        Return System.Configuration.ConfigurationManager.ConnectionStrings("Conn").ConnectionString
    End Function
    Public Function MySelect(ByVal strsql As String) As DataTable
        cn.Open()
        Dim comm As New MySqlCommand(strsql, cn)
        Dim da As New MySqlDataAdapter(comm)
        Dim dt As New DataTable
        da.Fill(dt)
        cn.Close()
        Return dt
    End Function
    Public Function MyCommand(ByVal strsql As String) As Boolean
        Dim result As Boolean = False
        cn.Open()
        Dim comm As MySqlCommand
        comm = cn.CreateCommand
        comm.CommandType = Data.CommandType.Text
        comm.CommandText = strsql
        comm.ExecuteNonQuery()
        cn.Close()
        result = True
        Return result
    End Function
    Public Function MyInsertIdentity(ByVal strsql As String) As Integer
        cn.Open()
        Dim comm As MySqlCommand
        comm = cn.CreateCommand
        comm.CommandType = Data.CommandType.Text
        comm.CommandText = strsql
        comm.ExecuteNonQuery()
        comm.CommandText = "SELECT @@IDENTITY"
        Dim Result As Integer = comm.ExecuteScalar
        cn.Close()
        Return Result
    End Function
    Public Function MySelectOneParameter(ByVal strsql As String, ByVal parameter As String) As String
        cn.Open()
        Dim cmd As New MySqlCommand(strsql, cn)
        Dim rd As MySqlDataReader = cmd.ExecuteReader()
        Dim res As String = 0
        rd.Read()
        If rd.HasRows Then
            res = IIf(IsDBNull(rd(parameter)), "0", rd(parameter))
        End If
        rd.Close()
        cn.Close()
        Return res
    End Function
    Public Shared Function MyInsertsTrasaction(ByVal Insert As String, ByVal InsertDetail As String) As Integer
        Dim result As Integer
        Dim cnn As MySqlConnection
        cnn = New MySqlConnection()
        cnn.ConnectionString = cadenaCon()
        cnn.Open()
        Dim comm As New MySqlCommand
        Dim transaccion As MySqlTransaction
        transaccion = cnn.BeginTransaction
        comm.Connection = cnn
        comm.Transaction = transaccion
        Try
            comm.CommandText = Insert
            comm.ExecuteNonQuery()
            comm.CommandText = "SELECT @@IDENTITY"
            result = comm.ExecuteScalar
            InsertDetail = InsertDetail.Replace("{id}", result)
            comm.CommandText = InsertDetail
            comm.ExecuteNonQuery()
            transaccion.Commit()
        Catch ex As Exception
            transaccion.Rollback()
            result = False
        Finally
            cnn.Close()
        End Try
        Return result
    End Function
End Class
