VERSION 5.00
Begin VB.Form SimpleOPCInterface 
   Caption         =   "Form1"
   ClientHeight    =   10170
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   18930
   LinkTopic       =   "Form1"
   ScaleHeight     =   10170
   ScaleWidth      =   18930
   StartUpPosition =   3  'Windows Default
   Begin VB.CommandButton AddOPCGroup 
      Caption         =   "Add Group"
      Enabled         =   0   'False
      Height          =   255
      Left            =   120
      TabIndex        =   188
      ToolTipText     =   "Once you have entered a group name and it's settings click here to add the group"
      Top             =   360
      Width           =   1935
   End
   Begin VB.TextBox OPCItemValue 
      Height          =   285
      Index           =   25
      Left            =   11160
      Locked          =   -1  'True
      TabIndex        =   161
      Top             =   5640
      Width           =   1455
   End
   Begin VB.TextBox OPCItemQuality 
      Height          =   285
      Index           =   25
      Left            =   17400
      Locked          =   -1  'True
      TabIndex        =   160
      Top             =   5640
      Width           =   855
   End
   Begin VB.TextBox OPCItemValueToWrite 
      Enabled         =   0   'False
      Height          =   285
      Index           =   25
      Left            =   12720
      TabIndex        =   159
      Text            =   "0"
      ToolTipText     =   "Enter the value to written here then click the 'Write Value' button"
      Top             =   5640
      Width           =   1455
   End
   Begin VB.CommandButton OPCItemWriteButton 
      Caption         =   "Write Value"
      Enabled         =   0   'False
      Height          =   255
      Index           =   25
      Left            =   14280
      TabIndex        =   158
      ToolTipText     =   "Click here to send the value entered in the 'Value to Write' field"
      Top             =   5640
      Width           =   975
   End
   Begin VB.CheckBox OPCItemActiveState 
      Alignment       =   1  'Right Justify
      Caption         =   "Active"
      Enabled         =   0   'False
      Height          =   255
      Index           =   25
      Left            =   15360
      TabIndex        =   157
      ToolTipText     =   "Click here to change the active state of this item"
      Top             =   5640
      Value           =   1  'Checked
      Width           =   855
   End
   Begin VB.CommandButton OPCItemSyncReadButton 
      Caption         =   "Sync Read"
      Enabled         =   0   'False
      Height          =   255
      Index           =   25
      Left            =   16320
      TabIndex        =   156
      ToolTipText     =   "Click here to perform a Synchronous read of this OPC Item"
      Top             =   5640
      Width           =   975
   End
   Begin VB.TextBox OPCItemValue 
      Height          =   285
      Index           =   24
      Left            =   11160
      Locked          =   -1  'True
      TabIndex        =   155
      Top             =   5280
      Width           =   1455
   End
   Begin VB.TextBox OPCItemQuality 
      Height          =   285
      Index           =   24
      Left            =   17400
      Locked          =   -1  'True
      TabIndex        =   154
      Top             =   5280
      Width           =   855
   End
   Begin VB.TextBox OPCItemValueToWrite 
      Enabled         =   0   'False
      Height          =   285
      Index           =   24
      Left            =   12720
      TabIndex        =   153
      Text            =   "0"
      ToolTipText     =   "Enter the value to written here then click the 'Write Value' button"
      Top             =   5280
      Width           =   1455
   End
   Begin VB.CommandButton OPCItemWriteButton 
      Caption         =   "Write Value"
      Enabled         =   0   'False
      Height          =   255
      Index           =   24
      Left            =   14280
      TabIndex        =   152
      ToolTipText     =   "Click here to send the value entered in the 'Value to Write' field"
      Top             =   5280
      Width           =   975
   End
   Begin VB.CheckBox OPCItemActiveState 
      Alignment       =   1  'Right Justify
      Caption         =   "Active"
      Enabled         =   0   'False
      Height          =   255
      Index           =   24
      Left            =   15360
      TabIndex        =   151
      ToolTipText     =   "Click here to change the active state of this item"
      Top             =   5280
      Value           =   1  'Checked
      Width           =   855
   End
   Begin VB.CommandButton OPCItemSyncReadButton 
      Caption         =   "Sync Read"
      Enabled         =   0   'False
      Height          =   255
      Index           =   24
      Left            =   16320
      TabIndex        =   150
      ToolTipText     =   "Click here to perform a Synchronous read of this OPC Item"
      Top             =   5280
      Width           =   975
   End
   Begin VB.TextBox OPCItemValue 
      Height          =   285
      Index           =   23
      Left            =   11160
      Locked          =   -1  'True
      TabIndex        =   149
      Top             =   4560
      Width           =   1455
   End
   Begin VB.TextBox OPCItemValue 
      Height          =   285
      Index           =   22
      Left            =   11160
      Locked          =   -1  'True
      TabIndex        =   148
      Top             =   4920
      Width           =   1455
   End
   Begin VB.TextBox OPCItemQuality 
      Height          =   285
      Index           =   23
      Left            =   17400
      Locked          =   -1  'True
      TabIndex        =   147
      Top             =   4560
      Width           =   855
   End
   Begin VB.TextBox OPCItemQuality 
      Height          =   285
      Index           =   22
      Left            =   17400
      Locked          =   -1  'True
      TabIndex        =   146
      Top             =   4920
      Width           =   855
   End
   Begin VB.TextBox OPCItemValueToWrite 
      Enabled         =   0   'False
      Height          =   285
      Index           =   23
      Left            =   12720
      TabIndex        =   145
      Text            =   "0"
      ToolTipText     =   "Enter the value to written here then click the 'Write Value' button"
      Top             =   4560
      Width           =   1455
   End
   Begin VB.TextBox OPCItemValueToWrite 
      Enabled         =   0   'False
      Height          =   285
      Index           =   22
      Left            =   12720
      TabIndex        =   144
      Text            =   "0"
      ToolTipText     =   "Enter the value to written here then click the 'Write Value' button"
      Top             =   4920
      Width           =   1455
   End
   Begin VB.CommandButton OPCItemWriteButton 
      Caption         =   "Write Value"
      Enabled         =   0   'False
      Height          =   255
      Index           =   23
      Left            =   14280
      TabIndex        =   143
      ToolTipText     =   "Click here to send the value entered in the 'Value to Write' field"
      Top             =   4560
      Width           =   975
   End
   Begin VB.CommandButton OPCItemWriteButton 
      Caption         =   "Write Value"
      Enabled         =   0   'False
      Height          =   255
      Index           =   22
      Left            =   14280
      TabIndex        =   142
      ToolTipText     =   "Click here to send the value entered in the 'Value to Write' field"
      Top             =   4920
      Width           =   975
   End
   Begin VB.CheckBox OPCItemActiveState 
      Alignment       =   1  'Right Justify
      Caption         =   "Active"
      Enabled         =   0   'False
      Height          =   255
      Index           =   23
      Left            =   15360
      TabIndex        =   141
      ToolTipText     =   "Click here to change the active state of this item"
      Top             =   4560
      Value           =   1  'Checked
      Width           =   855
   End
   Begin VB.CheckBox OPCItemActiveState 
      Alignment       =   1  'Right Justify
      Caption         =   "Active"
      Enabled         =   0   'False
      Height          =   255
      Index           =   22
      Left            =   15360
      TabIndex        =   140
      ToolTipText     =   "Click here to change the active state of this item"
      Top             =   4920
      Value           =   1  'Checked
      Width           =   855
   End
   Begin VB.CommandButton OPCItemSyncReadButton 
      Caption         =   "Sync Read"
      Enabled         =   0   'False
      Height          =   255
      Index           =   23
      Left            =   16320
      TabIndex        =   139
      ToolTipText     =   "Click here to perform a Synchronous read of this OPC Item"
      Top             =   4560
      Width           =   975
   End
   Begin VB.CommandButton OPCItemSyncReadButton 
      Caption         =   "Sync Read"
      Enabled         =   0   'False
      Height          =   255
      Index           =   22
      Left            =   16320
      TabIndex        =   138
      ToolTipText     =   "Click here to perform a Synchronous read of this OPC Item"
      Top             =   4920
      Width           =   975
   End
   Begin VB.TextBox OPCItemValue 
      Height          =   285
      Index           =   21
      Left            =   11160
      Locked          =   -1  'True
      TabIndex        =   137
      Top             =   4200
      Width           =   1455
   End
   Begin VB.TextBox OPCItemQuality 
      Height          =   285
      Index           =   21
      Left            =   17400
      Locked          =   -1  'True
      TabIndex        =   136
      Top             =   4200
      Width           =   855
   End
   Begin VB.TextBox OPCItemValueToWrite 
      Enabled         =   0   'False
      Height          =   285
      Index           =   21
      Left            =   12720
      TabIndex        =   135
      Text            =   "0"
      ToolTipText     =   "Enter the value to written here then click the 'Write Value' button"
      Top             =   4200
      Width           =   1455
   End
   Begin VB.CommandButton OPCItemWriteButton 
      Caption         =   "Write Value"
      Enabled         =   0   'False
      Height          =   255
      Index           =   21
      Left            =   14280
      TabIndex        =   134
      ToolTipText     =   "Click here to send the value entered in the 'Value to Write' field"
      Top             =   4200
      Width           =   975
   End
   Begin VB.CheckBox OPCItemActiveState 
      Alignment       =   1  'Right Justify
      Caption         =   "Active"
      Enabled         =   0   'False
      Height          =   255
      Index           =   21
      Left            =   15360
      TabIndex        =   133
      ToolTipText     =   "Click here to change the active state of this item"
      Top             =   4200
      Value           =   1  'Checked
      Width           =   855
   End
   Begin VB.CommandButton OPCItemSyncReadButton 
      Caption         =   "Sync Read"
      Enabled         =   0   'False
      Height          =   255
      Index           =   21
      Left            =   16320
      TabIndex        =   132
      ToolTipText     =   "Click here to perform a Synchronous read of this OPC Item"
      Top             =   4200
      Width           =   975
   End
   Begin VB.TextBox OPCItemValue 
      Height          =   285
      Index           =   20
      Left            =   11160
      Locked          =   -1  'True
      TabIndex        =   131
      Top             =   3840
      Width           =   1455
   End
   Begin VB.TextBox OPCItemQuality 
      Height          =   285
      Index           =   20
      Left            =   17400
      Locked          =   -1  'True
      TabIndex        =   130
      Top             =   3840
      Width           =   855
   End
   Begin VB.TextBox OPCItemValueToWrite 
      Enabled         =   0   'False
      Height          =   285
      Index           =   20
      Left            =   12720
      TabIndex        =   129
      Text            =   "0"
      ToolTipText     =   "Enter the value to written here then click the 'Write Value' button"
      Top             =   3840
      Width           =   1455
   End
   Begin VB.CommandButton OPCItemWriteButton 
      Caption         =   "Write Value"
      Enabled         =   0   'False
      Height          =   255
      Index           =   20
      Left            =   14280
      TabIndex        =   128
      ToolTipText     =   "Click here to send the value entered in the 'Value to Write' field"
      Top             =   3840
      Width           =   975
   End
   Begin VB.CheckBox OPCItemActiveState 
      Alignment       =   1  'Right Justify
      Caption         =   "Active"
      Enabled         =   0   'False
      Height          =   255
      Index           =   20
      Left            =   15360
      TabIndex        =   127
      ToolTipText     =   "Click here to change the active state of this item"
      Top             =   3840
      Value           =   1  'Checked
      Width           =   855
   End
   Begin VB.CommandButton OPCItemSyncReadButton 
      Caption         =   "Sync Read"
      Enabled         =   0   'False
      Height          =   255
      Index           =   20
      Left            =   16320
      TabIndex        =   126
      ToolTipText     =   "Click here to perform a Synchronous read of this OPC Item"
      Top             =   3840
      Width           =   975
   End
   Begin VB.TextBox OPCItemValue 
      Height          =   285
      Index           =   19
      Left            =   11160
      Locked          =   -1  'True
      TabIndex        =   125
      Top             =   3480
      Width           =   1455
   End
   Begin VB.TextBox OPCItemQuality 
      Height          =   285
      Index           =   19
      Left            =   17400
      Locked          =   -1  'True
      TabIndex        =   124
      Top             =   3480
      Width           =   855
   End
   Begin VB.TextBox OPCItemValueToWrite 
      Enabled         =   0   'False
      Height          =   285
      Index           =   19
      Left            =   12720
      TabIndex        =   123
      Text            =   "0"
      ToolTipText     =   "Enter the value to written here then click the 'Write Value' button"
      Top             =   3480
      Width           =   1455
   End
   Begin VB.CommandButton OPCItemWriteButton 
      Caption         =   "Write Value"
      Enabled         =   0   'False
      Height          =   255
      Index           =   19
      Left            =   14280
      TabIndex        =   122
      ToolTipText     =   "Click here to send the value entered in the 'Value to Write' field"
      Top             =   3480
      Width           =   975
   End
   Begin VB.CheckBox OPCItemActiveState 
      Alignment       =   1  'Right Justify
      Caption         =   "Active"
      Enabled         =   0   'False
      Height          =   255
      Index           =   19
      Left            =   15360
      TabIndex        =   121
      ToolTipText     =   "Click here to change the active state of this item"
      Top             =   3480
      Value           =   1  'Checked
      Width           =   855
   End
   Begin VB.CommandButton OPCItemSyncReadButton 
      Caption         =   "Sync Read"
      Enabled         =   0   'False
      Height          =   255
      Index           =   19
      Left            =   16320
      TabIndex        =   120
      ToolTipText     =   "Click here to perform a Synchronous read of this OPC Item"
      Top             =   3480
      Width           =   975
   End
   Begin VB.TextBox OPCItemValue 
      Height          =   285
      Index           =   18
      Left            =   11160
      Locked          =   -1  'True
      TabIndex        =   119
      Top             =   3120
      Width           =   1455
   End
   Begin VB.TextBox OPCItemQuality 
      Height          =   285
      Index           =   18
      Left            =   17400
      Locked          =   -1  'True
      TabIndex        =   118
      Top             =   3120
      Width           =   855
   End
   Begin VB.TextBox OPCItemValueToWrite 
      Enabled         =   0   'False
      Height          =   285
      Index           =   18
      Left            =   12720
      TabIndex        =   117
      Text            =   "0"
      ToolTipText     =   "Enter the value to written here then click the 'Write Value' button"
      Top             =   3120
      Width           =   1455
   End
   Begin VB.CommandButton OPCItemWriteButton 
      Caption         =   "Write Value"
      Enabled         =   0   'False
      Height          =   255
      Index           =   18
      Left            =   14280
      TabIndex        =   116
      ToolTipText     =   "Click here to send the value entered in the 'Value to Write' field"
      Top             =   3120
      Width           =   975
   End
   Begin VB.CheckBox OPCItemActiveState 
      Alignment       =   1  'Right Justify
      Caption         =   "Active"
      Enabled         =   0   'False
      Height          =   255
      Index           =   18
      Left            =   15360
      TabIndex        =   115
      ToolTipText     =   "Click here to change the active state of this item"
      Top             =   3120
      Value           =   1  'Checked
      Width           =   855
   End
   Begin VB.CommandButton OPCItemSyncReadButton 
      Caption         =   "Sync Read"
      Enabled         =   0   'False
      Height          =   255
      Index           =   18
      Left            =   16320
      TabIndex        =   114
      ToolTipText     =   "Click here to perform a Synchronous read of this OPC Item"
      Top             =   3120
      Width           =   975
   End
   Begin VB.TextBox OPCItemValue 
      Height          =   285
      Index           =   17
      Left            =   1920
      Locked          =   -1  'True
      TabIndex        =   113
      Top             =   9240
      Width           =   1455
   End
   Begin VB.TextBox OPCItemQuality 
      Height          =   285
      Index           =   17
      Left            =   8160
      Locked          =   -1  'True
      TabIndex        =   112
      Top             =   9240
      Width           =   855
   End
   Begin VB.TextBox OPCItemValueToWrite 
      Enabled         =   0   'False
      Height          =   285
      Index           =   17
      Left            =   3480
      TabIndex        =   111
      Text            =   "0"
      ToolTipText     =   "Enter the value to written here then click the 'Write Value' button"
      Top             =   9240
      Width           =   1455
   End
   Begin VB.CommandButton OPCItemWriteButton 
      Caption         =   "Write Value"
      Enabled         =   0   'False
      Height          =   255
      Index           =   17
      Left            =   5040
      TabIndex        =   110
      ToolTipText     =   "Click here to send the value entered in the 'Value to Write' field"
      Top             =   9240
      Width           =   975
   End
   Begin VB.CheckBox OPCItemActiveState 
      Alignment       =   1  'Right Justify
      Caption         =   "Active"
      Enabled         =   0   'False
      Height          =   255
      Index           =   17
      Left            =   6120
      TabIndex        =   109
      ToolTipText     =   "Click here to change the active state of this item"
      Top             =   9240
      Value           =   1  'Checked
      Width           =   855
   End
   Begin VB.CommandButton OPCItemSyncReadButton 
      Caption         =   "Sync Read"
      Enabled         =   0   'False
      Height          =   255
      Index           =   17
      Left            =   7080
      TabIndex        =   108
      ToolTipText     =   "Click here to perform a Synchronous read of this OPC Item"
      Top             =   9240
      Width           =   975
   End
   Begin VB.TextBox OPCItemValue 
      Height          =   285
      Index           =   16
      Left            =   1920
      Locked          =   -1  'True
      TabIndex        =   107
      Top             =   8880
      Width           =   1455
   End
   Begin VB.TextBox OPCItemQuality 
      Height          =   285
      Index           =   16
      Left            =   8160
      Locked          =   -1  'True
      TabIndex        =   106
      Top             =   8880
      Width           =   855
   End
   Begin VB.TextBox OPCItemValueToWrite 
      Enabled         =   0   'False
      Height          =   285
      Index           =   16
      Left            =   3480
      TabIndex        =   105
      Text            =   "0"
      ToolTipText     =   "Enter the value to written here then click the 'Write Value' button"
      Top             =   8880
      Width           =   1455
   End
   Begin VB.CommandButton OPCItemWriteButton 
      Caption         =   "Write Value"
      Enabled         =   0   'False
      Height          =   255
      Index           =   16
      Left            =   5040
      TabIndex        =   104
      ToolTipText     =   "Click here to send the value entered in the 'Value to Write' field"
      Top             =   8880
      Width           =   975
   End
   Begin VB.CheckBox OPCItemActiveState 
      Alignment       =   1  'Right Justify
      Caption         =   "Active"
      Enabled         =   0   'False
      Height          =   255
      Index           =   16
      Left            =   6120
      TabIndex        =   103
      ToolTipText     =   "Click here to change the active state of this item"
      Top             =   8880
      Value           =   1  'Checked
      Width           =   855
   End
   Begin VB.CommandButton OPCItemSyncReadButton 
      Caption         =   "Sync Read"
      Enabled         =   0   'False
      Height          =   255
      Index           =   16
      Left            =   7080
      TabIndex        =   102
      ToolTipText     =   "Click here to perform a Synchronous read of this OPC Item"
      Top             =   8880
      Width           =   975
   End
   Begin VB.TextBox OPCItemValue 
      Height          =   285
      Index           =   15
      Left            =   1920
      Locked          =   -1  'True
      TabIndex        =   101
      Top             =   8520
      Width           =   1455
   End
   Begin VB.TextBox OPCItemQuality 
      Height          =   285
      Index           =   15
      Left            =   8160
      Locked          =   -1  'True
      TabIndex        =   100
      Top             =   8520
      Width           =   855
   End
   Begin VB.TextBox OPCItemValueToWrite 
      Enabled         =   0   'False
      Height          =   285
      Index           =   15
      Left            =   3480
      TabIndex        =   99
      Text            =   "0"
      ToolTipText     =   "Enter the value to written here then click the 'Write Value' button"
      Top             =   8520
      Width           =   1455
   End
   Begin VB.CommandButton OPCItemWriteButton 
      Caption         =   "Write Value"
      Enabled         =   0   'False
      Height          =   255
      Index           =   15
      Left            =   5040
      TabIndex        =   98
      ToolTipText     =   "Click here to send the value entered in the 'Value to Write' field"
      Top             =   8520
      Width           =   975
   End
   Begin VB.CheckBox OPCItemActiveState 
      Alignment       =   1  'Right Justify
      Caption         =   "Active"
      Enabled         =   0   'False
      Height          =   255
      Index           =   15
      Left            =   6120
      TabIndex        =   97
      ToolTipText     =   "Click here to change the active state of this item"
      Top             =   8520
      Value           =   1  'Checked
      Width           =   855
   End
   Begin VB.CommandButton OPCItemSyncReadButton 
      Caption         =   "Sync Read"
      Enabled         =   0   'False
      Height          =   255
      Index           =   15
      Left            =   7080
      TabIndex        =   96
      ToolTipText     =   "Click here to perform a Synchronous read of this OPC Item"
      Top             =   8520
      Width           =   975
   End
   Begin VB.TextBox OPCItemValue 
      Height          =   285
      Index           =   14
      Left            =   1920
      Locked          =   -1  'True
      TabIndex        =   95
      Top             =   8160
      Width           =   1455
   End
   Begin VB.TextBox OPCItemValue 
      Height          =   285
      Index           =   13
      Left            =   1920
      Locked          =   -1  'True
      TabIndex        =   94
      Top             =   7800
      Width           =   1455
   End
   Begin VB.TextBox OPCItemQuality 
      Height          =   285
      Index           =   14
      Left            =   8160
      Locked          =   -1  'True
      TabIndex        =   93
      Top             =   8160
      Width           =   855
   End
   Begin VB.TextBox OPCItemQuality 
      Height          =   285
      Index           =   13
      Left            =   8160
      Locked          =   -1  'True
      TabIndex        =   92
      Top             =   7800
      Width           =   855
   End
   Begin VB.TextBox OPCItemValueToWrite 
      Enabled         =   0   'False
      Height          =   285
      Index           =   14
      Left            =   3480
      TabIndex        =   91
      Text            =   "0"
      ToolTipText     =   "Enter the value to written here then click the 'Write Value' button"
      Top             =   8160
      Width           =   1455
   End
   Begin VB.TextBox OPCItemValueToWrite 
      Enabled         =   0   'False
      Height          =   285
      Index           =   13
      Left            =   3480
      TabIndex        =   90
      Text            =   "0"
      ToolTipText     =   "Enter the value to written here then click the 'Write Value' button"
      Top             =   7800
      Width           =   1455
   End
   Begin VB.CommandButton OPCItemWriteButton 
      Caption         =   "Write Value"
      Enabled         =   0   'False
      Height          =   255
      Index           =   14
      Left            =   5040
      TabIndex        =   89
      ToolTipText     =   "Click here to send the value entered in the 'Value to Write' field"
      Top             =   8160
      Width           =   975
   End
   Begin VB.CommandButton OPCItemWriteButton 
      Caption         =   "Write Value"
      Enabled         =   0   'False
      Height          =   255
      Index           =   13
      Left            =   5040
      TabIndex        =   88
      ToolTipText     =   "Click here to send the value entered in the 'Value to Write' field"
      Top             =   7800
      Width           =   975
   End
   Begin VB.CheckBox OPCItemActiveState 
      Alignment       =   1  'Right Justify
      Caption         =   "Active"
      Enabled         =   0   'False
      Height          =   255
      Index           =   14
      Left            =   6120
      TabIndex        =   87
      ToolTipText     =   "Click here to change the active state of this item"
      Top             =   8160
      Value           =   1  'Checked
      Width           =   855
   End
   Begin VB.CheckBox OPCItemActiveState 
      Alignment       =   1  'Right Justify
      Caption         =   "Active"
      Enabled         =   0   'False
      Height          =   255
      Index           =   13
      Left            =   6120
      TabIndex        =   86
      ToolTipText     =   "Click here to change the active state of this item"
      Top             =   7800
      Value           =   1  'Checked
      Width           =   855
   End
   Begin VB.CommandButton OPCItemSyncReadButton 
      Caption         =   "Sync Read"
      Enabled         =   0   'False
      Height          =   255
      Index           =   14
      Left            =   7080
      TabIndex        =   85
      ToolTipText     =   "Click here to perform a Synchronous read of this OPC Item"
      Top             =   8160
      Width           =   975
   End
   Begin VB.CommandButton OPCItemSyncReadButton 
      Caption         =   "Sync Read"
      Enabled         =   0   'False
      Height          =   255
      Index           =   13
      Left            =   7080
      TabIndex        =   84
      ToolTipText     =   "Click here to perform a Synchronous read of this OPC Item"
      Top             =   7800
      Width           =   975
   End
   Begin VB.TextBox OPCItemValue 
      Height          =   285
      Index           =   12
      Left            =   1920
      Locked          =   -1  'True
      TabIndex        =   83
      Top             =   7440
      Width           =   1455
   End
   Begin VB.TextBox OPCItemQuality 
      Height          =   285
      Index           =   12
      Left            =   8160
      Locked          =   -1  'True
      TabIndex        =   82
      Top             =   7440
      Width           =   855
   End
   Begin VB.TextBox OPCItemValueToWrite 
      Enabled         =   0   'False
      Height          =   285
      Index           =   12
      Left            =   3480
      TabIndex        =   81
      Text            =   "0"
      ToolTipText     =   "Enter the value to written here then click the 'Write Value' button"
      Top             =   7440
      Width           =   1455
   End
   Begin VB.CommandButton OPCItemWriteButton 
      Caption         =   "Write Value"
      Enabled         =   0   'False
      Height          =   255
      Index           =   12
      Left            =   5040
      TabIndex        =   80
      ToolTipText     =   "Click here to send the value entered in the 'Value to Write' field"
      Top             =   7440
      Width           =   975
   End
   Begin VB.CheckBox OPCItemActiveState 
      Alignment       =   1  'Right Justify
      Caption         =   "Active"
      Enabled         =   0   'False
      Height          =   255
      Index           =   12
      Left            =   6120
      TabIndex        =   79
      ToolTipText     =   "Click here to change the active state of this item"
      Top             =   7440
      Value           =   1  'Checked
      Width           =   855
   End
   Begin VB.CommandButton OPCItemSyncReadButton 
      Caption         =   "Sync Read"
      Enabled         =   0   'False
      Height          =   255
      Index           =   12
      Left            =   7080
      TabIndex        =   78
      ToolTipText     =   "Click here to perform a Synchronous read of this OPC Item"
      Top             =   7440
      Width           =   975
   End
   Begin VB.TextBox OPCItemValue 
      Height          =   285
      Index           =   11
      Left            =   1920
      Locked          =   -1  'True
      TabIndex        =   77
      Top             =   7080
      Width           =   1455
   End
   Begin VB.TextBox OPCItemQuality 
      Height          =   285
      Index           =   11
      Left            =   8160
      Locked          =   -1  'True
      TabIndex        =   76
      Top             =   7080
      Width           =   855
   End
   Begin VB.TextBox OPCItemValueToWrite 
      Enabled         =   0   'False
      Height          =   285
      Index           =   11
      Left            =   3480
      TabIndex        =   75
      Text            =   "0"
      ToolTipText     =   "Enter the value to written here then click the 'Write Value' button"
      Top             =   7080
      Width           =   1455
   End
   Begin VB.CommandButton OPCItemWriteButton 
      Caption         =   "Write Value"
      Enabled         =   0   'False
      Height          =   255
      Index           =   11
      Left            =   5040
      TabIndex        =   74
      ToolTipText     =   "Click here to send the value entered in the 'Value to Write' field"
      Top             =   7080
      Width           =   975
   End
   Begin VB.CheckBox OPCItemActiveState 
      Alignment       =   1  'Right Justify
      Caption         =   "Active"
      Enabled         =   0   'False
      Height          =   255
      Index           =   11
      Left            =   6120
      TabIndex        =   73
      ToolTipText     =   "Click here to change the active state of this item"
      Top             =   7080
      Value           =   1  'Checked
      Width           =   855
   End
   Begin VB.CommandButton OPCItemSyncReadButton 
      Caption         =   "Sync Read"
      Enabled         =   0   'False
      Height          =   255
      Index           =   11
      Left            =   7080
      TabIndex        =   72
      ToolTipText     =   "Click here to perform a Synchronous read of this OPC Item"
      Top             =   7080
      Width           =   975
   End
   Begin VB.TextBox OPCItemValue 
      Height          =   285
      Index           =   10
      Left            =   1920
      Locked          =   -1  'True
      TabIndex        =   71
      Top             =   6720
      Width           =   1455
   End
   Begin VB.TextBox OPCItemQuality 
      Height          =   285
      Index           =   10
      Left            =   8160
      Locked          =   -1  'True
      TabIndex        =   70
      Top             =   6720
      Width           =   855
   End
   Begin VB.TextBox OPCItemValueToWrite 
      Enabled         =   0   'False
      Height          =   285
      Index           =   10
      Left            =   3480
      TabIndex        =   69
      Text            =   "0"
      ToolTipText     =   "Enter the value to written here then click the 'Write Value' button"
      Top             =   6720
      Width           =   1455
   End
   Begin VB.CommandButton OPCItemWriteButton 
      Caption         =   "Write Value"
      Enabled         =   0   'False
      Height          =   255
      Index           =   10
      Left            =   5040
      TabIndex        =   68
      ToolTipText     =   "Click here to send the value entered in the 'Value to Write' field"
      Top             =   6720
      Width           =   975
   End
   Begin VB.CheckBox OPCItemActiveState 
      Alignment       =   1  'Right Justify
      Caption         =   "Active"
      Enabled         =   0   'False
      Height          =   255
      Index           =   10
      Left            =   6120
      TabIndex        =   67
      ToolTipText     =   "Click here to change the active state of this item"
      Top             =   6720
      Value           =   1  'Checked
      Width           =   855
   End
   Begin VB.CommandButton OPCItemSyncReadButton 
      Caption         =   "Sync Read"
      Enabled         =   0   'False
      Height          =   255
      Index           =   10
      Left            =   7080
      TabIndex        =   66
      ToolTipText     =   "Click here to perform a Synchronous read of this OPC Item"
      Top             =   6720
      Width           =   975
   End
   Begin VB.CommandButton OPCAddItems 
      Caption         =   "Add OPC Items"
      Enabled         =   0   'False
      Height          =   255
      Left            =   120
      TabIndex        =   2
      ToolTipText     =   "Click here to add the OPC item names you have entered to the group"
      Top             =   600
      Width           =   1935
   End
   Begin VB.TextBox OPCItemValue 
      Height          =   285
      Index           =   0
      Left            =   1920
      Locked          =   -1  'True
      TabIndex        =   62
      Top             =   3120
      Width           =   1455
   End
   Begin VB.TextBox OPCItemQuality 
      Height          =   285
      Index           =   0
      Left            =   8160
      Locked          =   -1  'True
      TabIndex        =   61
      Top             =   3120
      Width           =   855
   End
   Begin VB.TextBox OPCItemValueToWrite 
      Enabled         =   0   'False
      Height          =   285
      Index           =   0
      Left            =   3480
      TabIndex        =   60
      Text            =   "0"
      ToolTipText     =   "Enter the value to written here then click the 'Write Value' button"
      Top             =   3120
      Width           =   1455
   End
   Begin VB.CommandButton OPCItemWriteButton 
      Caption         =   "Write Value"
      Enabled         =   0   'False
      Height          =   255
      Index           =   0
      Left            =   5040
      TabIndex        =   59
      ToolTipText     =   "Click here to send the value entered in the 'Value to Write' field using a Synchronous Write"
      Top             =   3120
      Width           =   975
   End
   Begin VB.CheckBox OPCItemActiveState 
      Alignment       =   1  'Right Justify
      Caption         =   "Active"
      Enabled         =   0   'False
      Height          =   255
      Index           =   0
      Left            =   6120
      TabIndex        =   58
      ToolTipText     =   "Click here to change the active state of this item"
      Top             =   3120
      Value           =   1  'Checked
      Width           =   855
   End
   Begin VB.CommandButton OPCItemSyncReadButton 
      Caption         =   "Sync Read"
      Enabled         =   0   'False
      Height          =   255
      Index           =   0
      Left            =   7080
      TabIndex        =   57
      ToolTipText     =   "Click here to perform a Synchronous read of this OPC Item"
      Top             =   3120
      Width           =   975
   End
   Begin VB.CommandButton OPCItemSyncReadButton 
      Caption         =   "Sync Read"
      Enabled         =   0   'False
      Height          =   255
      Index           =   9
      Left            =   7080
      TabIndex        =   56
      ToolTipText     =   "Click here to perform a Synchronous read of this OPC Item"
      Top             =   6360
      Width           =   975
   End
   Begin VB.CommandButton OPCItemSyncReadButton 
      Caption         =   "Sync Read"
      Enabled         =   0   'False
      Height          =   255
      Index           =   8
      Left            =   7080
      TabIndex        =   55
      ToolTipText     =   "Click here to perform a Synchronous read of this OPC Item"
      Top             =   6000
      Width           =   975
   End
   Begin VB.CommandButton OPCItemSyncReadButton 
      Caption         =   "Sync Read"
      Enabled         =   0   'False
      Height          =   255
      Index           =   7
      Left            =   7080
      TabIndex        =   54
      ToolTipText     =   "Click here to perform a Synchronous read of this OPC Item"
      Top             =   5640
      Width           =   975
   End
   Begin VB.CommandButton OPCItemSyncReadButton 
      Caption         =   "Sync Read"
      Enabled         =   0   'False
      Height          =   255
      Index           =   6
      Left            =   7080
      TabIndex        =   53
      ToolTipText     =   "Click here to perform a Synchronous read of this OPC Item"
      Top             =   5280
      Width           =   975
   End
   Begin VB.CommandButton OPCItemSyncReadButton 
      Caption         =   "Sync Read"
      Enabled         =   0   'False
      Height          =   255
      Index           =   5
      Left            =   7080
      TabIndex        =   52
      ToolTipText     =   "Click here to perform a Synchronous read of this OPC Item"
      Top             =   4920
      Width           =   975
   End
   Begin VB.CommandButton OPCItemSyncReadButton 
      Caption         =   "Sync Read"
      Enabled         =   0   'False
      Height          =   255
      Index           =   4
      Left            =   7080
      TabIndex        =   51
      ToolTipText     =   "Click here to perform a Synchronous read of this OPC Item"
      Top             =   4560
      Width           =   975
   End
   Begin VB.CommandButton OPCItemSyncReadButton 
      Caption         =   "Sync Read"
      Enabled         =   0   'False
      Height          =   255
      Index           =   3
      Left            =   7080
      TabIndex        =   50
      ToolTipText     =   "Click here to perform a Synchronous read of this OPC Item"
      Top             =   4200
      Width           =   975
   End
   Begin VB.CommandButton OPCItemSyncReadButton 
      Caption         =   "Sync Read"
      Enabled         =   0   'False
      Height          =   255
      Index           =   2
      Left            =   7080
      TabIndex        =   49
      ToolTipText     =   "Click here to perform a Synchronous read of this OPC Item"
      Top             =   3840
      Width           =   975
   End
   Begin VB.CommandButton OPCItemSyncReadButton 
      Caption         =   "Sync Read"
      Enabled         =   0   'False
      Height          =   255
      Index           =   1
      Left            =   7080
      TabIndex        =   48
      ToolTipText     =   "Click here to perform a Synchronous read of this OPC Item"
      Top             =   3480
      Width           =   975
   End
   Begin VB.CheckBox OPCItemActiveState 
      Alignment       =   1  'Right Justify
      Caption         =   "Active"
      Enabled         =   0   'False
      Height          =   255
      Index           =   9
      Left            =   6120
      TabIndex        =   47
      ToolTipText     =   "Click here to change the active state of this item"
      Top             =   6360
      Value           =   1  'Checked
      Width           =   855
   End
   Begin VB.CheckBox OPCItemActiveState 
      Alignment       =   1  'Right Justify
      Caption         =   "Active"
      Enabled         =   0   'False
      Height          =   255
      Index           =   8
      Left            =   6120
      TabIndex        =   46
      ToolTipText     =   "Click here to change the active state of this item"
      Top             =   6000
      Value           =   1  'Checked
      Width           =   855
   End
   Begin VB.CheckBox OPCItemActiveState 
      Alignment       =   1  'Right Justify
      Caption         =   "Active"
      Enabled         =   0   'False
      Height          =   255
      Index           =   7
      Left            =   6120
      TabIndex        =   45
      ToolTipText     =   "Click here to change the active state of this item"
      Top             =   5640
      Value           =   1  'Checked
      Width           =   855
   End
   Begin VB.CheckBox OPCItemActiveState 
      Alignment       =   1  'Right Justify
      Caption         =   "Active"
      Enabled         =   0   'False
      Height          =   255
      Index           =   6
      Left            =   6120
      TabIndex        =   44
      ToolTipText     =   "Click here to change the active state of this item"
      Top             =   5280
      Value           =   1  'Checked
      Width           =   855
   End
   Begin VB.CheckBox OPCItemActiveState 
      Alignment       =   1  'Right Justify
      Caption         =   "Active"
      Enabled         =   0   'False
      Height          =   255
      Index           =   5
      Left            =   6120
      TabIndex        =   43
      ToolTipText     =   "Click here to change the active state of this item"
      Top             =   4920
      Value           =   1  'Checked
      Width           =   855
   End
   Begin VB.CheckBox OPCItemActiveState 
      Alignment       =   1  'Right Justify
      Caption         =   "Active"
      Enabled         =   0   'False
      Height          =   255
      Index           =   4
      Left            =   6120
      TabIndex        =   42
      ToolTipText     =   "Click here to change the active state of this item"
      Top             =   4560
      Value           =   1  'Checked
      Width           =   855
   End
   Begin VB.CheckBox OPCItemActiveState 
      Alignment       =   1  'Right Justify
      Caption         =   "Active"
      Enabled         =   0   'False
      Height          =   255
      Index           =   3
      Left            =   6120
      TabIndex        =   41
      ToolTipText     =   "Click here to change the active state of this item"
      Top             =   4200
      Value           =   1  'Checked
      Width           =   855
   End
   Begin VB.CheckBox OPCItemActiveState 
      Alignment       =   1  'Right Justify
      Caption         =   "Active"
      Enabled         =   0   'False
      Height          =   255
      Index           =   2
      Left            =   6120
      TabIndex        =   40
      ToolTipText     =   "Click here to change the active state of this item"
      Top             =   3840
      Value           =   1  'Checked
      Width           =   855
   End
   Begin VB.CheckBox OPCItemActiveState 
      Alignment       =   1  'Right Justify
      Caption         =   "Active"
      Enabled         =   0   'False
      Height          =   255
      Index           =   1
      Left            =   6120
      TabIndex        =   39
      ToolTipText     =   "Click here to change the active state of this item"
      Top             =   3480
      Value           =   1  'Checked
      Width           =   855
   End
   Begin VB.CommandButton OPCItemWriteButton 
      Caption         =   "Write Value"
      Enabled         =   0   'False
      Height          =   255
      Index           =   9
      Left            =   5040
      TabIndex        =   38
      ToolTipText     =   "Click here to send the value entered in the 'Value to Write' field"
      Top             =   6360
      Width           =   975
   End
   Begin VB.CommandButton OPCItemWriteButton 
      Caption         =   "Write Value"
      Enabled         =   0   'False
      Height          =   255
      Index           =   8
      Left            =   5040
      TabIndex        =   37
      ToolTipText     =   "Click here to send the value entered in the 'Value to Write' field"
      Top             =   6000
      Width           =   975
   End
   Begin VB.CommandButton OPCItemWriteButton 
      Caption         =   "Write Value"
      Enabled         =   0   'False
      Height          =   255
      Index           =   7
      Left            =   5040
      TabIndex        =   36
      ToolTipText     =   "Click here to send the value entered in the 'Value to Write' field"
      Top             =   5640
      Width           =   975
   End
   Begin VB.CommandButton OPCItemWriteButton 
      Caption         =   "Write Value"
      Enabled         =   0   'False
      Height          =   255
      Index           =   6
      Left            =   5040
      TabIndex        =   35
      ToolTipText     =   "Click here to send the value entered in the 'Value to Write' field"
      Top             =   5280
      Width           =   975
   End
   Begin VB.CommandButton OPCItemWriteButton 
      Caption         =   "Write Value"
      Enabled         =   0   'False
      Height          =   255
      Index           =   5
      Left            =   5040
      TabIndex        =   34
      ToolTipText     =   "Click here to send the value entered in the 'Value to Write' field"
      Top             =   4920
      Width           =   975
   End
   Begin VB.CommandButton OPCItemWriteButton 
      Caption         =   "Write Value"
      Enabled         =   0   'False
      Height          =   255
      Index           =   4
      Left            =   5040
      TabIndex        =   33
      ToolTipText     =   "Click here to send the value entered in the 'Value to Write' field"
      Top             =   4560
      Width           =   975
   End
   Begin VB.CommandButton OPCItemWriteButton 
      Caption         =   "Write Value"
      Enabled         =   0   'False
      Height          =   255
      Index           =   3
      Left            =   5040
      TabIndex        =   32
      ToolTipText     =   "Click here to send the value entered in the 'Value to Write' field"
      Top             =   4200
      Width           =   975
   End
   Begin VB.CommandButton OPCItemWriteButton 
      Caption         =   "Write Value"
      Enabled         =   0   'False
      Height          =   255
      Index           =   2
      Left            =   5040
      TabIndex        =   31
      ToolTipText     =   "Click here to send the value entered in the 'Value to Write' field"
      Top             =   3840
      Width           =   975
   End
   Begin VB.CommandButton OPCItemWriteButton 
      Caption         =   "Write Value"
      Enabled         =   0   'False
      Height          =   255
      Index           =   1
      Left            =   5040
      TabIndex        =   30
      ToolTipText     =   "Click here to send the value entered in the 'Value to Write' field using a Synchronous Write"
      Top             =   3480
      Width           =   975
   End
   Begin VB.TextBox OPCItemValueToWrite 
      Enabled         =   0   'False
      Height          =   285
      Index           =   9
      Left            =   3480
      TabIndex        =   29
      Text            =   "0"
      ToolTipText     =   "Enter the value to written here then click the 'Write Value' button"
      Top             =   6360
      Width           =   1455
   End
   Begin VB.TextBox OPCItemValueToWrite 
      Enabled         =   0   'False
      Height          =   285
      Index           =   8
      Left            =   3480
      TabIndex        =   28
      Text            =   "0"
      ToolTipText     =   "Enter the value to written here then click the 'Write Value' button"
      Top             =   6000
      Width           =   1455
   End
   Begin VB.TextBox OPCItemValueToWrite 
      Enabled         =   0   'False
      Height          =   285
      Index           =   7
      Left            =   3480
      TabIndex        =   27
      Text            =   "0"
      ToolTipText     =   "Enter the value to written here then click the 'Write Value' button"
      Top             =   5640
      Width           =   1455
   End
   Begin VB.TextBox OPCItemValueToWrite 
      Enabled         =   0   'False
      Height          =   285
      Index           =   6
      Left            =   3480
      TabIndex        =   26
      Text            =   "0"
      ToolTipText     =   "Enter the value to written here then click the 'Write Value' button"
      Top             =   5280
      Width           =   1455
   End
   Begin VB.TextBox OPCItemValueToWrite 
      Enabled         =   0   'False
      Height          =   285
      Index           =   5
      Left            =   3480
      TabIndex        =   25
      Text            =   "0"
      ToolTipText     =   "Enter the value to written here then click the 'Write Value' button"
      Top             =   4920
      Width           =   1455
   End
   Begin VB.TextBox OPCItemValueToWrite 
      Enabled         =   0   'False
      Height          =   285
      Index           =   4
      Left            =   3480
      TabIndex        =   24
      Text            =   "0"
      ToolTipText     =   "Enter the value to written here then click the 'Write Value' button"
      Top             =   4560
      Width           =   1455
   End
   Begin VB.TextBox OPCItemValueToWrite 
      Enabled         =   0   'False
      Height          =   285
      Index           =   3
      Left            =   3480
      TabIndex        =   23
      Text            =   "0"
      ToolTipText     =   "Enter the value to written here then click the 'Write Value' button"
      Top             =   4200
      Width           =   1455
   End
   Begin VB.TextBox OPCItemValueToWrite 
      Enabled         =   0   'False
      Height          =   285
      Index           =   2
      Left            =   3480
      TabIndex        =   22
      Text            =   "0"
      ToolTipText     =   "Enter the value to written here then click the 'Write Value' button"
      Top             =   3840
      Width           =   1455
   End
   Begin VB.TextBox OPCItemValueToWrite 
      Enabled         =   0   'False
      Height          =   285
      Index           =   1
      Left            =   3480
      TabIndex        =   21
      Text            =   "0"
      ToolTipText     =   "Enter the value to written here then click the 'Write Value' button"
      Top             =   3480
      Width           =   1455
   End
   Begin VB.TextBox OPCItemQuality 
      Height          =   285
      Index           =   9
      Left            =   8160
      Locked          =   -1  'True
      TabIndex        =   20
      Top             =   6360
      Width           =   855
   End
   Begin VB.TextBox OPCItemQuality 
      Height          =   285
      Index           =   8
      Left            =   8160
      Locked          =   -1  'True
      TabIndex        =   19
      Top             =   6000
      Width           =   855
   End
   Begin VB.TextBox OPCItemQuality 
      Height          =   285
      Index           =   7
      Left            =   8160
      Locked          =   -1  'True
      TabIndex        =   18
      Top             =   5640
      Width           =   855
   End
   Begin VB.TextBox OPCItemQuality 
      Height          =   285
      Index           =   6
      Left            =   8160
      Locked          =   -1  'True
      TabIndex        =   17
      Top             =   5280
      Width           =   855
   End
   Begin VB.TextBox OPCItemQuality 
      Height          =   285
      Index           =   5
      Left            =   8160
      Locked          =   -1  'True
      TabIndex        =   16
      Top             =   4920
      Width           =   855
   End
   Begin VB.TextBox OPCItemQuality 
      Height          =   285
      Index           =   4
      Left            =   8160
      Locked          =   -1  'True
      TabIndex        =   15
      Top             =   4560
      Width           =   855
   End
   Begin VB.TextBox OPCItemQuality 
      Height          =   285
      Index           =   3
      Left            =   8160
      Locked          =   -1  'True
      TabIndex        =   14
      Top             =   4200
      Width           =   855
   End
   Begin VB.TextBox OPCItemQuality 
      Height          =   285
      Index           =   2
      Left            =   8160
      Locked          =   -1  'True
      TabIndex        =   13
      Top             =   3840
      Width           =   855
   End
   Begin VB.TextBox OPCItemQuality 
      Height          =   285
      Index           =   1
      Left            =   8160
      Locked          =   -1  'True
      TabIndex        =   12
      Top             =   3480
      Width           =   855
   End
   Begin VB.TextBox OPCItemValue 
      Height          =   285
      Index           =   9
      Left            =   1920
      Locked          =   -1  'True
      TabIndex        =   11
      Top             =   6360
      Width           =   1455
   End
   Begin VB.TextBox OPCItemValue 
      Height          =   285
      Index           =   8
      Left            =   1920
      Locked          =   -1  'True
      TabIndex        =   10
      Top             =   6000
      Width           =   1455
   End
   Begin VB.TextBox OPCItemValue 
      Height          =   285
      Index           =   7
      Left            =   1920
      Locked          =   -1  'True
      TabIndex        =   9
      Top             =   5640
      Width           =   1455
   End
   Begin VB.TextBox OPCItemValue 
      Height          =   285
      Index           =   6
      Left            =   1920
      Locked          =   -1  'True
      TabIndex        =   8
      Top             =   5280
      Width           =   1455
   End
   Begin VB.TextBox OPCItemValue 
      Height          =   285
      Index           =   5
      Left            =   1920
      Locked          =   -1  'True
      TabIndex        =   7
      Top             =   4920
      Width           =   1455
   End
   Begin VB.TextBox OPCItemValue 
      Height          =   285
      Index           =   4
      Left            =   1920
      Locked          =   -1  'True
      TabIndex        =   6
      Top             =   4560
      Width           =   1455
   End
   Begin VB.TextBox OPCItemValue 
      Height          =   285
      Index           =   3
      Left            =   1920
      Locked          =   -1  'True
      TabIndex        =   5
      Top             =   4200
      Width           =   1455
   End
   Begin VB.TextBox OPCItemValue 
      Height          =   285
      Index           =   2
      Left            =   1920
      Locked          =   -1  'True
      TabIndex        =   4
      Top             =   3840
      Width           =   1455
   End
   Begin VB.TextBox OPCItemValue 
      Height          =   285
      Index           =   1
      Left            =   1920
      Locked          =   -1  'True
      TabIndex        =   3
      Top             =   3480
      Width           =   1455
   End
   Begin VB.CommandButton ExitExample 
      Caption         =   "Quit"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   13.5
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   510
      Left            =   17400
      TabIndex        =   1
      Top             =   9480
      Width           =   1455
   End
   Begin VB.CommandButton OPCServerConnect 
      Caption         =   "Connect"
      Height          =   255
      Left            =   120
      TabIndex        =   0
      ToolTipText     =   "Press the 'Connect' button once you have selected an OPC Server"
      Top             =   120
      Width           =   1935
   End
   Begin VB.Label Label32 
      Caption         =   "Fin Turno 1"
      Height          =   255
      Left            =   480
      TabIndex        =   187
      Top             =   9240
      Width           =   1335
   End
   Begin VB.Label Label31 
      Caption         =   "Ini Turno 1"
      Height          =   255
      Left            =   480
      TabIndex        =   186
      Top             =   8880
      Width           =   1335
   End
   Begin VB.Label Label30 
      Caption         =   "Turno Anterior"
      Height          =   255
      Left            =   9720
      TabIndex        =   185
      Top             =   5640
      Width           =   1335
   End
   Begin VB.Label Label29 
      Caption         =   "Turno Actual"
      Height          =   255
      Left            =   9720
      TabIndex        =   184
      Top             =   5280
      Width           =   1335
   End
   Begin VB.Label Label28 
      Caption         =   "Fin Turno 4"
      Height          =   255
      Left            =   9720
      TabIndex        =   183
      Top             =   4920
      Width           =   1335
   End
   Begin VB.Label Label27 
      Caption         =   "Ini Turno 4"
      Height          =   255
      Left            =   9720
      TabIndex        =   182
      Top             =   4560
      Width           =   1335
   End
   Begin VB.Label Label26 
      Caption         =   "Fin Turno 3"
      Height          =   255
      Left            =   9720
      TabIndex        =   181
      Top             =   4200
      Width           =   1335
   End
   Begin VB.Label Label25 
      Caption         =   "Ini Turno 3"
      Height          =   255
      Left            =   9720
      TabIndex        =   180
      Top             =   3840
      Width           =   1335
   End
   Begin VB.Label Label24 
      Caption         =   "Fin Turno2"
      Height          =   255
      Left            =   9720
      TabIndex        =   179
      Top             =   3480
      Width           =   1335
   End
   Begin VB.Label Label23 
      Caption         =   "Ini Turno 2"
      Height          =   255
      Left            =   9720
      TabIndex        =   178
      Top             =   3120
      Width           =   1335
   End
   Begin VB.Label Label22 
      Caption         =   "Tiempo prenda act"
      Height          =   255
      Left            =   480
      TabIndex        =   177
      Top             =   8520
      Width           =   1335
   End
   Begin VB.Label Label21 
      Caption         =   "Promedio tiempo"
      Height          =   255
      Left            =   480
      TabIndex        =   176
      Top             =   8160
      Width           =   1335
   End
   Begin VB.Label Label20 
      Caption         =   "Tiempo ult prenda"
      Height          =   255
      Left            =   480
      TabIndex        =   175
      Top             =   7800
      Width           =   1335
   End
   Begin VB.Label Label19 
      Caption         =   "Nro Operarios"
      Height          =   255
      Left            =   480
      TabIndex        =   174
      Top             =   7440
      Width           =   1335
   End
   Begin VB.Label Label18 
      Caption         =   "Prod Turno Ant"
      Height          =   255
      Left            =   480
      TabIndex        =   173
      Top             =   7080
      Width           =   1335
   End
   Begin VB.Label Label17 
      Caption         =   "Produccion turno"
      Height          =   255
      Left            =   480
      TabIndex        =   172
      Top             =   6720
      Width           =   1335
   End
   Begin VB.Label Label16 
      Caption         =   "Prod Acumulado"
      Height          =   255
      Left            =   480
      TabIndex        =   171
      Top             =   6360
      Width           =   1335
   End
   Begin VB.Label Label15 
      Caption         =   "Objetivo Hr"
      Height          =   255
      Left            =   480
      TabIndex        =   170
      Top             =   6000
      Width           =   1335
   End
   Begin VB.Label Label14 
      Caption         =   "Productividad  Hr"
      Height          =   255
      Left            =   480
      TabIndex        =   169
      Top             =   5640
      Width           =   1335
   End
   Begin VB.Label Label13 
      Caption         =   "Prod Hr Ant"
      Height          =   255
      Left            =   480
      TabIndex        =   168
      Top             =   5280
      Width           =   1335
   End
   Begin VB.Label Label12 
      Caption         =   "Produccion Hr"
      Height          =   255
      Left            =   480
      TabIndex        =   167
      Top             =   4920
      Width           =   1335
   End
   Begin VB.Label Label11 
      Caption         =   "Fecha"
      Height          =   255
      Left            =   480
      TabIndex        =   166
      Top             =   4560
      Width           =   1335
   End
   Begin VB.Label Label10 
      Caption         =   "Hora"
      Height          =   255
      Left            =   480
      TabIndex        =   165
      Top             =   4200
      Width           =   1335
   End
   Begin VB.Label Label4 
      Caption         =   "Set Fecha"
      Height          =   255
      Left            =   480
      TabIndex        =   164
      Top             =   3840
      Width           =   1335
   End
   Begin VB.Label Label3 
      Caption         =   "Set Hora"
      Height          =   255
      Left            =   480
      TabIndex        =   163
      Top             =   3480
      Width           =   1335
   End
   Begin VB.Label Label2 
      Caption         =   "Comando"
      Height          =   255
      Left            =   480
      TabIndex        =   162
      Top             =   3120
      Width           =   1335
   End
   Begin VB.Label Label7 
      Caption         =   "Current Value"
      Height          =   255
      Left            =   1920
      TabIndex        =   65
      Top             =   2880
      Width           =   1335
   End
   Begin VB.Label Label8 
      Caption         =   "Item Quality"
      Height          =   255
      Left            =   8160
      TabIndex        =   64
      Top             =   2880
      Width           =   855
   End
   Begin VB.Label Label9 
      Caption         =   "Value to Write"
      Height          =   255
      Left            =   3720
      TabIndex        =   63
      Top             =   2880
      Width           =   1215
   End
End
Attribute VB_Name = "SimpleOPCInterface"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
' This example attempts to demonstrate the steps required to connect
' with and access data from and OPC server.  Using the Data Access 2.0
' automation interface installed when you installed KEPServer, this
' example will give you a general understanding of this powerful interface
' and the steps required to use it.  If you have used KEPServer in your
' Visual Basic applications as a DDE server you will be impressed with the
' performance gains that OPC connectivity provides.  The steps required to
' use an OPC server in your VB application is a little more involved than
' simple TextBox DDE links but the benefits far outweigh the extra effort.
' Hopefully this example will make even the extra effort seem trivial.
'
' In this example and its operation you will see that the steps of connecting
' with, adding a group, and adding items have been purposely imposed by the
' enabling and disabling of the controls on this form.  The goal of this hand
' holding is to insure that your application connects with and uses OPC data in
' the proper sequence.  That sequence being 1) Connect with the Server.
' 2) Add group(s) 3) Add items to group(s).  The same steps should be done in
' reverse order when disconnecting from the server.  As always VB gives you a
' great deal of freedom, your resulting application may need to take many steps
' to achieve its goal but you should attempt to follow these steps if possible.
'
' This code is provided "AS IS". KEPware makes no guarantee that this code will
' be bug free.  The code is for demonstration purposes only.  In order to keep
' this example reasonably clear there is not as much error handling in place.
' Your application may need more error handling for reliable operation.
'
' This exmaple project has already been configured to reference the
' 'OPC Automation 2.0' object.  When creating your own OPC applications from
' scratch you must first add the 'OPC Automation 2.0' object to the reference
' object list.  This can be done from the VB menu Project|References.  Once
' the References Dialog is displayed, scroll down to the 'OPC Automation 2.0'
' object and select it, then click the OK button.  You'll know that the
' 'OPC Automation 2.0' object is being referenced when VB displays smart
' object properties for the OPC related objects as you use them.

'***************************************************************************
' 06/23/06 - Modified to refernece the OPCDAAuto.dll file rather then the
' legacy KEPOPCDAAUTO.dll file.
'***************************************************************************

Option Explicit
Option Base 1

' Server and group related data
' The OPCServer objects must be declared here due to the use of WithEvents
Dim WithEvents AnOPCServer As OPCServer
Attribute AnOPCServer.VB_VarHelpID = -1
Dim WithEvents ConnectedOPCServer As OPCServer
Attribute ConnectedOPCServer.VB_VarHelpID = -1
Dim ConnectedServerGroup As OPCGroups
Dim WithEvents ConnectedGroup As OPCGroup
Attribute ConnectedGroup.VB_VarHelpID = -1

' OPC Item related data
Dim OPCItemCollection As OPCItems
Dim OneOPCItem As OPCItem
Dim ItemCount As Long
Dim OPCItemIDs(26) As String
Dim ItemServerHandles() As Long
Dim ItemServerErrors() As Long
Dim ClientHandles(26) As Long

' General startup initialization
Private Sub Form_Load()
    'AvailableOPCServerList.AddItem "Click on 'List OPC Servers' to start"
End Sub

' Make sure things get shut down properly upon closing application
Private Sub Form_Terminate()
    Call ExitExample_Click
End Sub





' This sub handles gathering a list of available OPC Servers and displays them
' The OPCServer Object provides a method called 'GetOPCServers' that will allow
' you to get a list of the OPC Servers that are installed on your machine.  The
' list is retured as a string array.
Private Sub ListOPCServers_Click()
    Dim AllOPCServers As Variant
    Dim i As Integer

    'Set error handling for OPC Function
    On Error GoTo ShowOPCGetServersError

    ' Create a temporary OPCServer object and use it to get the list of
    ' available OPC Servers
    Set AnOPCServer = New OPCServer
    ' Clear the list control used to display them
    AvailableOPCServerList.Clear
    AllOPCServers = AnOPCServer.GetOPCServers
    ' Load the list returned into the List box for user selection
    For i = LBound(AllOPCServers) To UBound(AllOPCServers)
        AvailableOPCServerList.AddItem AllOPCServers(i)
    Next i
    
    GoTo SkipOPCGetServersError
    
ShowOPCGetServersError:
    Call DisplayOPC_COM_ErrorValue("Get OPC Server List", Err.Number)
SkipOPCGetServersError:
    ' Release the temporary OPCServer object now that we're done with it
    Set AnOPCServer = Nothing
    
End Sub

' This sub loads the OPC Server name when selected from the list
' and places it in the OPCServerName object
Private Sub AvailableOPCServerList_Click()
    ' When a user selects a server from the list box its name is placed
    ' in the OPCServerName
    OPCServerName = AvailableOPCServerList.List(AvailableOPCServerList.ListIndex)
End Sub


' This sub handles connecting with the selected OPC Server
' The OPCServer Object provides a method called 'Connect' that allows you
' to 'connect' with an OPC server.  The 'Connect' method can take two arguments,
' a server name and a Node name.  The Node name is optional and does not have to
' be used to connect to a local server.  When the 'Connect' method is called you
' should see the OPC Server application start if it is not aleady running.
'
'Special Note: When connect remotely to another PC running the KepserverEx make
'sure that you have properly configured DCOM on both PC's. You will find documentation
'explaining exactly how to do this on your installation CD or at the Kepware web site.
'The web site is www.kepware.com.
Private Sub OPCServerConnect_Click()
Dim ConnectedServerName As String
Dim ConnectedNodeName As Variant
    'Set error handling for OPC Function
    On Error GoTo ShowOPCConnectError
    '
    'Create a new OPC Server object
    Set ConnectedOPCServer = New OPCServer
    'Load the selected server name to start the interface
    ConnectedServerName = "KEPware.KEPServerEx.V4" 'OPCServerName.Text
    'Attempt to connect with the server
    ConnectedOPCServer.Connect ConnectedServerName, ConnectedNodeName
    
    ' Throughout this example you will see a lot of code that simply enables
    ' and disables the various controls on the form.  The purpose of these
    ' actions is to demonstrate and insure the proper sequence of events when
    ' making an OPC connection.
    ' If we successfully connect to a server allow the user to disconnect
    'DisconnectFromServer.Enabled = True
    ' Don't allow a reconnect until the user disconnects
    OPCServerConnect.Enabled = False
    'AvailableOPCServerList.Enabled = False
    'OPCServerName.Enabled = False
    
    ' Enable the group controls now that we have a server connection
    AddOPCGroup.Enabled = True ' Remove group isn't enable until a group has been added
    
    GoTo SkipOPCConnectError
    
ShowOPCConnectError:
    'DisconnectFromServer.Enabled = False
    Set ConnectedOPCServer = Nothing
    Call DisplayOPC_COM_ErrorValue("Connect", Err.Number)
SkipOPCConnectError:
End Sub

' This sub handles disconnecting from the OPC Server.  The OPCServer Object
' provides the method 'Disconnect'.  Calling this on an active OPCSerer
' object will release the OPC Server interface with your application.  When
' this occurs you should see the OPC server application shut down if it started
' automatically on the OPC connect. This step should not occur until the group
' and items have been removed
Private Sub DisconnectFromServer_Click()

' Test to see if the OPC Server connection is currently available
If Not ConnectedOPCServer Is Nothing Then
    'Set error handling for OPC Function
    On Error GoTo ShowOPCDisconnectError

    'Disconnect from the server, This should only occur after the items and group
    ' have been removed
    ConnectedOPCServer.Disconnect
    
    ' Release the old instance of the OPC Server object and allow the resources
    ' to be freed
    Set ConnectedOPCServer = Nothing

    ' Allow a reconnect once the disconnect completes
    OPCServerConnect.Enabled = True
    'AvailableOPCServerList.Enabled = True
    'OPCServerName.Enabled = True
    
    ' Don't alllow the Disconnect to be issued now that the connection is closed
    'DisconnectFromServer.Enabled = False
    
    ' Disable the group controls now that we no longer have a server connection
    'OPCGroupName.Enabled = False
    'GroupUpdateRate.Enabled = False
    'GroupDeadBand.Enabled = False
    'GroupActiveState.Enabled = False
    AddOPCGroup.Enabled = False
End If
    
    GoTo SkipDisconnectError

ShowOPCDisconnectError:
    Call DisplayOPC_COM_ErrorValue("Disconnect", Err.Number)
SkipDisconnectError:
End Sub

' This sub handles adding the group to the OPC server and establishing the
' group interface.  When adding a group you can preset some of the group
' parameters using the properties '.DefaultGroupIsActive'
' and '.DefaultGroupDeadband'.  Set these before adding the group. Once the
' group has been successfully added you can change these same settings
' along with the group update rate on the fly using the properties on the
' resulting OPCGroup object.
Private Sub AddOPCGroup_Click()
    'Set error handling for OPC Function
    On Error GoTo ShowOPCGroupAddError

    'Prepare to add a group to the current OPC Server
    ' Get the group interface from the server object
    Set ConnectedServerGroup = ConnectedOPCServer.OPCGroups

    ' Set the desire active state for the group
    ConnectedServerGroup.DefaultGroupIsActive = True

    'Set the desired percent deadband
    ConnectedServerGroup.DefaultGroupDeadband = 0

    ' Add the group and set its update rate
    Set ConnectedGroup = ConnectedServerGroup.Add("Prod1")
    ' Set the update rate for the group
    ConnectedGroup.UpdateRate = 100
    
    ' ****************************************************************
    ' Mark this group to receive asynchronous updates via the DataChange event.
    ' This setting is IMPORTANT. Without setting '.IsSubcribed' to True your
    ' VB application will not receive DataChange notifications.  This will
    ' make it appear that you have not properly connected to the server.
    
    ConnectedGroup.IsSubscribed = True
    
    '*****************************************************************

    ' Now that a group has been added disable the Add group Button and enable
    ' the Remove group Button.  This demo application adds only a single group
    AddOPCGroup.Enabled = False
    'OPCGroupName.Enabled = False
    'RemoveOPCGroup.Enabled = True
    
    ' Enable the OPC item controls now that a group has been added
    OPCAddItems.Enabled = True


    ' Disable the Disconnect Server button since we now have a group that must be removed first
    'DisconnectFromServer.Enabled = False

    GoTo SkipAddGroupError

ShowOPCGroupAddError:
    Call DisplayOPC_COM_ErrorValue("Add Group", Err.Number)
SkipAddGroupError:

End Sub

' This sub handles removing a group from the OPC server, this must be done after
' items have been removed.  The 'Remove' method allows a group to be removed
' by name from the OPC Server.  If your application will maintains more than
' one group you will need to keep a list of the group names for use in the
' 'Remove' method.  In this demo there is only one group.  The name is maintained
' in the OPCGroupName TextBox but it can not be changed once the group is added.
Private Sub RemoveOPCGroup_Click()

' Test to see if the OPC Group object is currently available
If Not ConnectedServerGroup Is Nothing Then
    'Set error handling for OPC Function
    On Error GoTo ShowOPCGroupRemoveError

    ' Remove the group from the server
    ConnectedServerGroup.Remove ("Prod1")
    ' Release the group interface and allow the server to cleanup the resources used
    Set ConnectedServerGroup = Nothing
    Set ConnectedGroup = Nothing

    ' Enable the Add group Button and disable the Remove group Button
    AddOPCGroup.Enabled = True
    'OPCGroupName.Enabled = True
    'RemoveOPCGroup.Enabled = False
    ' Disable the item controls now that a group has been removed.
    ' Items can't be added without a group so prevent the user from editing them.
    OPCAddItems.Enabled = False
    Dim i As Integer

    
    ' Enable the Disconnect Server button since we have removed the group and can disconnect from the server properly
    'DisconnectFromServer.Enabled = True
End If

    GoTo SkipRemoveGroupError

ShowOPCGroupRemoveError:
    Call DisplayOPC_COM_ErrorValue("Remove Group", Err.Number)
SkipRemoveGroupError:
End Sub

' This sub allows the group's active state to be changed on the fly.  The
' OPCGroup object provides a number of properties that can be used to control
' a group's operation.  The '.IsActive' property allows you to turn all of the
' OPC items in the group On(active) and Off(inactive).  To see the effect that
' the group's '.InActive' property has on an OPC Server run this demo and connect
' with KEPServer, add the default group, add the default items.  Once you see
' changing data click on the CheckBox in the Group frame.  If you watch
' the KEPServer OPC Server you will see it's active tag count go from 10 when
' updating to 'No Active Items' when the group is made inactive.
' Changing the actvie state of a group can be useful in controlling how your
' application makes use of an OPC Servers communication bandwidth.  If you don't
' need any of the data in a given group simply set it inactive, this will allow an
' OPC Server to gather only the data current required by your application.
Private Sub GroupActiveState_Click()
    'Set error handling for OPC Function
    On Error GoTo ShowOPCGroupActiveError
    
    ' If the group has been added and exist then change its active state
    If Not ConnectedGroup Is Nothing Then
        ConnectedGroup.IsActive = GroupActiveState.Value
    End If

    GoTo SkipGroupActiveError

ShowOPCGroupActiveError:
    Call DisplayOPC_COM_ErrorValue("Group Active State", Err.Number)
SkipGroupActiveError:
    
End Sub

' This sub allows the group's deadband to be changed on the fly.  Like the
' '.IsActive' property, the '.DeadBand' property can be changed at any time.
' The Deadband property allows you to control how much change must occur in
' an OPC item in this group before the value will be reported in the 'DataChange'
' event.  The value entered for '.DeadBand' is 0 to 100 as a percentage of full
' scale for each OPC item data type within this group.  If your OPC item is a
' Short(VT_I2) then your full scale is -32768 to 32767 or 65535.  If you
' enter a Deadband value of 1% then all OPC Items in this goup would need
' to change by a value of 655 before the change would be returned in the
' 'DataChange' event.  The '.DeadBand' property is a floating point number
' allowing very small ranges of change to be filtered.
Private Sub GroupDeadBand_Change()
    'Set error handling for OPC Function
    On Error GoTo ShowOPCGroupDeadBandError
    
    ' If the group has been added and exist then change its dead band
    If Not ConnectedGroup Is Nothing Then
        ConnectedGroup.DeadBand = Val(GroupDeadBand.Text)
    End If

    GoTo SkipGroupDeadBandError

ShowOPCGroupDeadBandError:
    Call DisplayOPC_COM_ErrorValue("Group Dead Band", Err.Number)
SkipGroupDeadBandError:
End Sub

' This sub allows the group's update rate to be changed on the fly.  The
' '.UpdateRate' property allows you to control how often data from this
' group will be returned to your application in the 'DataChange' event.
' The '.UpdateRate' property can be used to control and improve the overall
' performance of you application.  In this example you can see that the update
' rate is set for maximum update speed.  In a demo that's OK.  In your real
' world application, forcing the OPC Server to gather all of the OPC items in
' a group at their fastest rate may not be ideal.  In applications where you
' have data that needs to be acquired at different rates you can create
' multiple groups each with its own update rate.  Using multiple groups would
' allow you to gather time critical data in GroupA with an update rate
' of 200 millliseconds, and gather low priority data from GroupB with an
' update rate of 7000 milliseconds.  The lowest value for the '.UpdateRate'
' is 0 which tells the OPC Server go as fast as possible.  The maximium is
' 2147483647 milliseconds which is about 596 hours.
Private Sub GroupUpdateRate_Change()
    'Set error handling for OPC Function
    On Error GoTo ShowOPCGroupUdateRateError
    
    ' If the group has been added and exist then change its update rate
    If Not ConnectedGroup Is Nothing Then
        ConnectedGroup.UpdateRate = Val(GroupUpdateRate.Text)
    End If

    GoTo SkipGroupUdateRateError

ShowOPCGroupUdateRateError:
    Call DisplayOPC_COM_ErrorValue("Group Update Rate", Err.Number)
SkipGroupUdateRateError:
End Sub

' This sub handles adding an OPC item to a group.  The group must be established first before
' any items can be added.  Once you  have a group added to the OPC Server you
' need to add item to the group.  The OPCItems object provides the methods and
' properties need to add item to an estabished OPC group.
Private Sub OPCAddItems_Click()
    'Set error handling for OPC Function
    On Error GoTo ShowOPCItemAddError
    
    ' In this example we have at most 10 items that we will attempt to add
    ' to the group.
    ItemCount = 26
    '
    ' Load the request OPC Item names and build the ClientHandles list
        ' Load the name of then item to be added to this group.  You can add
        ' as many items as you want to the group in a single call by building these
        ' arrays as needed.
        OPCItemIDs(1) = "serie.Prod1.CMD"
        OPCItemIDs(2) = "serie.prod1.SetTime"
        OPCItemIDs(3) = "serie.prod1.SetDate"
        OPCItemIDs(4) = "serie.prod1.Time"
        OPCItemIDs(5) = "serie.prod1.Date"
        OPCItemIDs(6) = "serie.prod1.ProdHs"
        OPCItemIDs(7) = "serie.prod1.ProdHsAnt"
        OPCItemIDs(8) = "serie.prod1.ProductivHs"
        OPCItemIDs(9) = "serie.prod1.ObjHs"
        OPCItemIDs(10) = "serie.prod1.ProdAcu"
        OPCItemIDs(11) = "serie.prod1.ProdTurno"
        OPCItemIDs(12) = "serie.prod1.ProdTurAnt"
        OPCItemIDs(13) = "serie.prod1.NroOper"
        OPCItemIDs(14) = "serie.prod1.UltTiempo"
        OPCItemIDs(15) = "serie.prod1.PromTiempo"
        OPCItemIDs(16) = "serie.prod1.AuxTiempo"
        OPCItemIDs(17) = "serie.prod1.IniT1"
        OPCItemIDs(18) = "serie.prod1.FinT1"
        OPCItemIDs(19) = "serie.prod1.IniT2"
        OPCItemIDs(20) = "serie.prod1.FinT2"
        OPCItemIDs(21) = "serie.prod1.IniT3"
        OPCItemIDs(22) = "serie.prod1.FinT3"
        OPCItemIDs(23) = "serie.prod1.IniT4"
        OPCItemIDs(24) = "serie.prod1.FinT4"
        OPCItemIDs(25) = "serie.prod1.TurnoAct"
        OPCItemIDs(26) = "serie.prod1.TurnoAnt"
        ' The client handles are given to the OPC Server for each item you intend
        ' to add to the group.  The OPC Server will uses these client handles
        ' by returning them to you in the 'DataChange' event.  You can use the
        ' client handles as a key to linking each valued returned from the Server
        ' back to some element in your application.  In this example we are simply
        ' placing the Index number of each control that will be used to display
        ' data for the item.  In your application the ClientHandle value you use
        ' can by whatever you need to best fit your program.  You will see how
        ' these client handles are used in the 'DataChange' event handler.
        Dim i As Integer
        For i = 0 To 25
            ClientHandles(i + 1) = i
        Next i
        ' Make the Items active start control Active, for the demo I want all itme to start active
        ' Your application may need to start the items as inactive.


    ' Establish a connection to the OPC item interface of the connected group
    Set OPCItemCollection = ConnectedGroup.OPCItems
    
    ' Setting the '.DefaultIsActive' property forces all items we are about to
    ' add to the group to be added in an active state.  If you want to add them
    ' all as inactive simply set this property false, you can always make the
    ' items active later as needed using each item's own active state property.
    ' One key distinction to note, the active state of an item is independent
    ' from the group active state.  If a group is active but the item is
    ' inactive no data will be received for the item.  Also changing the
    ' state of the group will not change the state of an item.
    OPCItemCollection.DefaultIsActive = True
    
    ' Atempt to add the items,  some may fail so the ItemServerErrors will need
    ' to be check on completion of the call.  We are adding all item using the
    ' default data type of VT_EMPTY and letting the server pick the appropriate
    ' data type.  The ItemServerHandles is an array that the OPC Server will
    ' return to your application.  This array like your own ClientHandles array
    ' is used by the server to allow you to reference individual items in an OPC
    ' group.  When you need to perform an action on a single OPC item you will
    ' need to use the ItemServerHandles for that item.  With this said you need to
    ' maintain the ItemServerHandles array for use throughout your application.
    ' Use of the ItemServerHandles will be demonstrated in other subroutines in
    ' this example program.
    OPCItemCollection.AddItems ItemCount, OPCItemIDs, ClientHandles, ItemServerHandles, ItemServerErrors
    
    ' This next step checks the error return on each item we attempted to
    ' register.  If an item is in error it's associated controls will be
    ' disabled.  If all items are in error then the Add Item button will
    ' remain active.
    Dim AnItemIsGood As Boolean
    AnItemIsGood = False
    For i = 0 To 25
        If ItemServerErrors(i + 1) = 0 Then ' If the item was added successfully then allow it to be used.
            OPCItemValueToWrite(i).Enabled = True
            OPCItemWriteButton(i).Enabled = True
            OPCItemActiveState(i).Enabled = True
            OPCItemSyncReadButton(i).Enabled = True
            AnItemIsGood = True
        Else
            ItemServerHandles(i + 1) = 0 ' If the handle was bad mark it as empty
            OPCItemValueToWrite(i).Enabled = False
            OPCItemWriteButton(i).Enabled = False
            OPCItemActiveState(i).Enabled = False
            OPCItemSyncReadButton(i).Enabled = False
        End If
        
    Next i
        
    ' Disable the Add OPC item button if any item in the list was good
    If AnItemIsGood Then
        OPCAddItems.Enabled = False
        'RemoveOPCGroup.Enabled = False  ' If an item has been don't allow the group to be removed until the item is removed
    Else
        ' The OPC Server did not accept any of the items we attempted to enter, let the user know to try again.
        Dim Response
        Response = MsgBox("The OPC Server has not accepted any of the item you have enter, check your item names and try again.", vbOKOnly, "OPC Add Item")
    End If

    GoTo SkipOPCItemAddError

ShowOPCItemAddError:
    Call DisplayOPC_COM_ErrorValue("OPC Add Items", Err.Number)
SkipOPCItemAddError:
End Sub

' This sub handles removing OPC items from a group.  Like the 'AddItems' method
' of the OPCItems object, the 'Remove' method allow us to remove item from
' an OPC group.  In this example we are removing all item from the group.
' In your application you may find it necessary to remove some items from
' a group while ading others.  Normally the best practice however it to add
' all the item you wish to use to the group and then control their active
' states indivudually.  You can control the active state of individual items
' in a group as shown in the 'OPCItemActiveState_Click' subroutine of this
' module.  With that said if you intend to remove the group you
' should first remove all its items.  The 'Remove' method uses the
' ItemServerHandles we received from the 'AddItems' method to properly remove
' only the items you wish.  This is an example of how ItemServerHandles are
' used by your application and the OPC Server.  As stated above, you can
' design your application to add and remove items as needed but that's not
' necessarily the most effiecent operation for the OPC Server.
Private Sub OPCRemoveItems_Click()
    If Not OPCItemCollection Is Nothing Then
        'Set error handling for OPC Function
        On Error GoTo ShowOPCRemoveItemError
    
        ItemCount = 1
        
        ' Provide an array to contain the ItemServerHandles of the item
        ' we intend to remove
        Dim RemoveItemServerHandles(26) As Long
        
        ' Array for potential error returns.  This example doesn't
        ' check them but yours should ultimately.
        Dim RemoveItemServerErrors() As Long
                
        ' Get the Servers handle for the desired items.  The server handles
        ' were returned in add item subroutine.  In this case we need to get
        ' only the handles for item that are valid.
        Dim i As Integer
        For i = 1 To 26
            ' In this example if the ItemServerHandle is non zero it is valid
            If ItemServerHandles(i) <> 0 Then
                RemoveItemServerHandles(ItemCount) = ItemServerHandles(i)
                ItemCount = ItemCount + 1
            End If
        Next i
    
        ' Item count is 1 greater than it needs to be at this point
        ItemCount = ItemCount - 1
        
        ' Invoke the Remove Item operation.  Remember this call will
        ' wait until completion
        OPCItemCollection.Remove ItemCount, RemoveItemServerHandles, RemoveItemServerErrors
    
        ' Clear the ItemServerHandles and turn off the controls for interacting
        ' with the OPC items on the form.
        For i = 0 To 25
            ItemServerHandles(i + 1) = 0 'Mark the handle as empty
            OPCItemValueToWrite(i).Enabled = False
            OPCItemWriteButton(i).Enabled = False
            OPCItemActiveState(i).Enabled = False
            OPCItemSyncReadButton(i).Enabled = False
        Next i
        
        ' Enable the Add OPC item button and Remove Group button now that the
        ' items are released
        OPCAddItems.Enabled = True
        'RemoveOPCGroup.Enabled = True
        
        ' Enable the OPC Item name controls to allow a new set of items
        ' to be entered
    
        ' Release the resources by the item collection interface
        Set OPCItemCollection = Nothing
   
    End If
            
        GoTo SkipOPCRemoveItemError

ShowOPCRemoveItemError:
    Call DisplayOPC_COM_ErrorValue("OPC Remove Items", Err.Number)
SkipOPCRemoveItemError:

End Sub

' This sub handles writing a single value to the server using the
' 'SyncWrite' write method.  The 'SyncWrite' method provides a
' quick(programming wise) means to send a value to an OPC Server.  The item
' you intend to write must already be part of an OPC group you have added
' and you must have the ItemServerHandle for the item.  This is another example
' of how the ItemServerHandle is used and why it is important to properly
' store and track these handles.  The 'SyncWrite' method while quick and easy
' will wait for the OPC Server to complete the operation.  Once you invoke
' the 'SyncWrite' method it could take a moment for the OPC Server to return
' control to your application.  For this example that's OK.  If your application
' can't tolerate a pause you can use the 'AsyncWrite' and its associated
' 'AsyncWriteComplete' call back event instead.  In this sub we are only
' writing one value at a time.  The 'SyncWrite' mehtod can take a list of
' writes to be performed allow you to write entire recipes to the server
' in one shot.  If you are going to write more than one item, the
' ItemServerHandles for each item must be from the same OPC Group.
Private Sub OPCItemWriteButton_Click(Index As Integer)
    'Set error handling for OPC Function
    On Error GoTo ShowOPCSyncWriteError
  
    ' Write only 1 item
    ItemCount = 1
    ' Create some local scope variables to hold the value to be sent.
    ' These arrays could just as easily contain all of the item we have added.
    Dim SyncItemValues(1) As Variant
    Dim SyncItemServerHandles(1) As Long
    Dim SyncItemServerErrors() As Long
    
    ' Get the Servers handle for the desired item.  The server handles
    ' were returned in add item subroutine.
    SyncItemServerHandles(1) = ItemServerHandles(Index + 1)
    
    ' Load the value to be written
    SyncItemValues(1) = Val(OPCItemValueToWrite(Index).Text)
    
    ' Invoke the SyncWrite operation.  Remember this call will wait until completion
    ConnectedGroup.SyncWrite ItemCount, SyncItemServerHandles, SyncItemValues, SyncItemServerErrors
            
    GoTo SkipOPCSyncWriteError

ShowOPCSyncWriteError:
    Call DisplayOPC_COM_ErrorValue("OPC Sync Write", Err.Number)
SkipOPCSyncWriteError:

End Sub

' This sub handles performing a single synchronous read from a single item
' using the 'SyncRead' method.  The 'SyncRead' method like the 'SyncWrite',
' will wait for comletion from the server before returning to your application.
' There are two sources for data an OPC Server can return to your application.
' The first source is from 'Cache' the other is from 'Device'.  The 'SyncRead'
' method allows you to choose where you want to get the data.  If you choose
' 'Cache' the data has the potential to be old data which you can determine by
' looking at the time stamp on the data.  If you know that the data you are
' requesting is actively being scanned by the OPC Server you should be able to
' invoke the 'SyncRead' method using the mode selection of 'OPCCache'.  If your
' not sure if the data you desire is being scanned by the server or its out of
' date, you can use the mode selection of 'OPCDevice'.  The 'OPCDevice' mode
' commands the OPC Server to go and get this item directly from the device and
' 'DO IT NOW'.  This pretty much insures that you will receive the most recent
' value for the itme your are requesting.  The downside, when reading from the
' device directly the 'SyncRead' method will wait for the device to complete
' that read operation which could include mire time, modem time, or any other
' factor that is required to gather data from the actual device.  There are some
' benefits to using a 'SyncRead'  in the 'OPCDevice' mode.  If you want to
' completely control the data acquisition cycle from your application you can
' add your groups, add your items, make the items inactive, then use the 'SyncRead'
' mehtod to forcibly make the server perform read operations when you want.
' Using this scheme the server would only talk to the the device when you invoke
' either a 'SyncRead' or 'SyncWrite' method.  In this example using the KEPServer
' simulator you can see this effect by connecting with KEPServer, adding the
' default group, adding the default items, and then clicking on the group active
' control.  With the data updates stopped you can now click on the SyncRead button
' for each item and see a single read occur.  If you look at the active tag count
' KEPServer you will see it momentarily increase each time you press the SyncRead
' button.
Private Sub OPCItemSyncReadButton_Click(Index As Integer)
    'Set error handling for OPC Function
    On Error GoTo ShowOPCSyncReadError
  
    ' Read only 1 item
    ItemCount = 1
    
    ' Provide storage the arrays returned by the 'SyncRead' method
    Dim SyncItemValues() As Variant
    Dim SyncItemServerHandles(1) As Long
    Dim SyncItemServerErrors() As Long
    
    ' Get the Servers handle for the desired item.  The server handles were
    ' returned in add item subroutine.
    SyncItemServerHandles(1) = ItemServerHandles(Index + 1)
    
    ' Invoke the SyncRead operation.  Remember this call will wait until
    ' completion. The source flag in this case, 'OPCDevice' , is set to
    ' read from device which may take some time.
    ConnectedGroup.SyncRead OPCDevice, ItemCount, SyncItemServerHandles, SyncItemValues, SyncItemServerErrors
    
    ' Save off the value returned after checking for error
    If SyncItemServerErrors(1) = 0 Then
        OPCItemValue(Index).Text = SyncItemValues(1)
    End If
        
    GoTo SkipOPCSyncReadError

ShowOPCSyncReadError:
    Call DisplayOPC_COM_ErrorValue("OPC Sync Read", Err.Number)
SkipOPCSyncReadError:
End Sub

' This Sub sets the active state of an individual item.  Like the other methods
' that perform operation on either a single item of list of items, the
' 'SetActive' method requires the ItemServerHandle of the item to be modified.
' Using the active state of an item allows you to control the amount of work
' the OPC Server is doing when communicating with a device.  You could add all
' the item you desire to read in an Active state but if some of those items are
' not currently in use you can improve the performance of the OPC Server by making
' those items inactive.  We suggest that you make the items not currently be used
' inactive instead of removing them from the group.  Watch the KEPServer
' active item count at the bottom of its windows as you change the state of
' items.
Private Sub OPCItemActiveState_Click(Index As Integer)
    'Set error handling for OPC Function
    On Error GoTo ShowOPCItemActiveStateError
  
    ' Change only 1 item
    ItemCount = 1
    ' Dim local arrays to pass desired item for state change
    Dim ActiveItemServerHandles(1) As Long
    Dim ActiveItemErrors() As Long
    Dim ActiveState As Boolean
    
    ' Get the desired state from the control.
    ActiveState = OPCItemActiveState(Index).Value
    ' Get the Servers handle for the desired item.  The server handles
    ' were returned in add item subroutine.
    ActiveItemServerHandles(1) = ItemServerHandles(Index + 1)
    
    ' Invoke the SetActive operation on the OPC item collection interface
    OPCItemCollection.SetActive ItemCount, ActiveItemServerHandles, ActiveState, ActiveItemErrors
    
    ' Your application should check for errors here.
          
    GoTo SkipOPCItemActiveStateError

ShowOPCItemActiveStateError:
    Call DisplayOPC_COM_ErrorValue("OPC Item Active State", Err.Number)
SkipOPCItemActiveStateError:
    
End Sub

' This sub handles the 'DataChange' call back event which returns data that has
' been detected as changed within the OPC Server.  This call back should be
' used primarily to receive the data.  Do not make any other calls back into
' the OPC server from this call back.  The other item related functions covered
' in this example have shown how the ItemServerHandle is used to control and
' manipulate individual items in the OPC server.  The 'DataChange' event allows
' us to see how the 'ClientHandles we gave the OPC Server when adding items are
' used.  As you can see here the server returns the 'ClientHandles' as an array.
' The number of item returned in this event can change from trigger to trigger
' so don't count on always getting a 1 to 1 match with the number of items
' you have registered.  That where the 'ClientHandles' come into play.  Using
' the 'ClientHandles' returned here you can determine what data has changed and
' where in your application the data should go.  In this example the
' 'ClientHandles' were the Index number of each item we added to the group.
' Using this returned index number the 'DataChange' handler shown here knows
' what controls need to be updated with new data.  In your application you can
' make the client handles anything you like as long as they allow you to
' uniquely identify each item as it returned in this event.
Sub ConnectedGroup_DataChange(ByVal TransactionID As Long, ByVal NumItems As Long, ClientHandles() As Long, ItemValues() As Variant, Qualities() As Long, TimeStamps() As Date)
    ' We don't have error handling here since this is an event called from the OPC interface
    
    Dim i As Integer
    For i = 1 To NumItems
        ' Use the 'Clienthandles' array returned by the server to pull out the
        ' index number of the control to update and load the value.
        OPCItemValue(ClientHandles(i)).Text = ItemValues(i)
        
        If ClientHandles(i) = 3 Then
            OPCItemValue(3).Text = Hex(ItemValues(i))
        End If
        ' Check the Qualties for each item retured here.  The actual contents of the
        ' quality field can contain bit field data which can provide specific
        ' error conditions.  Normally if everything is OK then the quality will
        ' contain the 0xC0
        If Qualities(i) And &HC0 Then
            OPCItemQuality(ClientHandles(i)).Text = "Good"
        Else
            OPCItemQuality(ClientHandles(i)).Text = Qualities(i)
        End If
    Next i
End Sub

' Handles displaying any OPC/COM/VB errors that are caught by the exception handler
Sub DisplayOPC_COM_ErrorValue(OPC_Function As String, ErrorCode As Long)
    Dim Response
    Dim ErrorDisplay As String
    ErrorDisplay = "The OPC function '" + OPC_Function + "' has returned an error of " + Str(ErrorCode) + " or Hex 0x" + Hex(ErrorCode)
    Response = MsgBox(ErrorDisplay, vbOKOnly, "OPC Function Error")
End Sub

' This sub handles exiting the example and properly disconnecting
' from the OPC server in an orderly fashion.  Like the force order
' of the controls on this form, the exit attempts to remove the Items
' from the group, then the group from the server and finally disconnect
' from the server.  This is also why each of the subroutines had the test
' to see if the Object to be removed was already set to 'Nothing'.
Private Sub ExitExample_Click()
    ' These calls will remove the OPC items, Group, and Disconnect in the proper order
    Call OPCRemoveItems_Click
    Call RemoveOPCGroup_Click
    Call DisconnectFromServer_Click
End
End Sub


