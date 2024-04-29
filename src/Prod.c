///////////////////////////////////////////////////////////////////////////////
//                    PROYECTO INDICADORES PRODUCTIVIDAD
//
//                VERSION 5
///////////////////////////////////////////////////////////////////////////////
/*
08/08/18 modificacion cantidad de pulsadores que incrementan produccion
         se agregan registros de tiempo de prenda para cada pulsador
*/

#include <16F886.h>                          // Definiciones del PIC 16F873
#RESERVE  0x07b:0X07F
#fuses HS,NOWDT,PROTECT,MCLR,NODEBUG,PUT,BROWNOUT,NOLVP,BORV21
#use delay(clock=20000000)                     // Oscilador a 20 Mhz
#priority RTCC,RDA,TBE

#pragma use fast_io(A)
#pragma use fast_io(B)
#pragma use fast_io(C)
#use rs232(baud=19200, BITS=8, xmit=PIN_C6, rcv=PIN_C7, enable=PIN_C5, ERRORS)// RS232 Estándar
#use I2C(master, sda=PIN_C4, scl=PIN_C3, force_hw, fast=100000)

//PINES DEL SHIFT REGISTER
#define pLedTX    pin_B0
#define pLedRX    pin_B1
#define pMR_SR    pin_B2  //MASTER RESET DEL SHIFT REGISTER
#define pDCLK_SR  pin_B3  //DATA CLOCK DEL SHIFT REGISTER   
#define pSCLK_SR  pin_B4  //STORAGE CLOCK DEL SHIFT REG
#define pOE_SR    pin_B5  //OUTPUT ENABLE DEL SHIFT REGISTER
#define pDATA_SR  pin_B6  //DATA DEL SHIFT REGISTER

//varios
#define pBUZZ  pin_B7     //BUZZER 
#define pREL1  pin_C0
#define pREL2  pin_C1
#define pIN1   pin_C2     //libre

int const kInmuni=5;
int const k1seg=99;//2
int const k100ms=10;
int const kFiltro=5;
int const kP2=15;
int const FwVer=5;

// VARIABLES EN RAM ///////////////////////////////////////////////////////////
/////////////////////////////////////////////////////
// REGISTROS MODBUS
/////////////////////////////////////////////////////
int16 rCmd=0;           //40001 comando
int16 rSetTime=0;       //40002 hora, minuto y segundo a setear en el DS en BCD
int16 rSetDate=0;       //40003 Dia de la semana/fecha/mes/anio a setear en el DS en BCD
int16 rTime=0;          //40004 hora, minuto y segundo actual BCD
INT16 rMinutosDec=0;    //minutos en formato decimal
//int16 rDate=0;        //40005 Dia de la semana/fecha/mes/anio BCD
//
int16 rProdHs=1;        //40005 producido horario, se resetea hora a hora
int16 rProdHrAnt=2;     //40006 cantidad producida en la hora anterior
int16 rProdHora=3;      //40007 productividad horaria
int16 rObjHs=4;         //40008 objetivo horario
//
int16 rProdAcu=5;       //40009 Productividad acumulada
int16 rProdTurno=6;     //40010 Produccion acumulada del turno
int16 rProdTurnoAnt=7;  //40011 producido turno anterior
int16 rTempObjHs=8;     //40012 temporario de produccion horaria para cuando se cambia el objetivo de la horaen el medio de una hora
int16 rUltTiempo=9;     //40013 demora ultima prenda (tiempo entre pulsado y pulsado de puls fin
int16 rDatoListo=10;    //40014 //le indica al scada que recolecte el dato
int16 rAuxTiempo=11;    //40015 tiempo de prenda actual
//turnos
int16 rIniT1=12;         //40016 inicio turno uno byte superior, hora, byte inferior, minutos
int16 rFinT1=13;         //40017 fin turno idem formato
int16 rIniT2=14;         //40018
int16 rFinT2=15;         //40019
int16 rIniT3=16;         //40020
int16 rFinT3=17;         //40021
int16 rIniT4=18;         //40022
int16 rFinT4=19;         //40023
int16 rTurnoAct=20;      //40024
int16 rTurnoAnt=21;      //40025
int16 rObjDia=22;        //40026
int16 rPantalla=23;      //40027 pantalla a mostrar, datos hr, datos turno, etc 
int16 rIniRecT1=24;      //40028 recreo en el turno 1
int16 rFinRecT1=25;      //40029 recreo en el turno 1
int16 rIniRecT2=26;      //40030 recreo en el truno 2
int16 rFinRecT2=27;      //40031 recreo en el turno 2
int16 rIniRecT3=28;      //40032 recreo en el turno 3
int16 rFinRecT3=29;      //40033 recreo en el turno 3
int16 rIniRecT4=30;      //40034 recreo en el truno 4
int16 rFinRecT4=31;      //40035 recreo en el turno 4
int16 rObjAcu=0;         //40036 objetivos acumulados durante el turno
int16 rObjHsAnt=4;       //40037 para detectar cambio de objetivo horario
int16 rContMin=0;        //40038 contador de minutos para set de flag cada una hora
int16 rT_Pren1=0;        //40039 tiempo prenda por pulsador1
int16 rT_Pren2=0;        //40040 tiempo prenda por pulsador2
int16 rT_Pren3=0;        //40041 tiempo prenda por pulsador3
int16 rT_Pren4=0;        //40042 tiempo prenda por pulsador4
int16 rAuxTiempo1=0;     //40043 
int16 rAuxTiempo2=0;     //40044 
int16 rAuxTiempo3=0;     //40045 
int16 rAuxTiempo4=0;     //40046 
int16 fEnPul=0x003F;     //40047


//1ra linea de digitos
int8  rMilL1=0;
int8  rCenL1=0;
int8  rDecL1=0;
int8  rUniL1=0;
//2da linea de digitos
int8  rMilL2=0;
int8  rCenL2=0;
int8  rDecL2=0;
int8  rUniL2=0;
//3da linea de digitos
int8  rMilL3=0;
int8  rCenL3=0;
int8  rDecL3=0;
int8  rUniL3=0;
//4da linea de digitos (hora)
int8  rMilL4=0;
int8  rCenL4=0;
int8  rDecL4=0;
int8  rUniL4=0;
//5da linea de digitos (hora)
int8  rMilL5=0;
int8  rCenL5=0;
int8  rDecL5=0;
int8  rUniL5=0;


//variables para mostrar cuando finaliza el turn
int16 rTempObjDia=0;
int16 rTempProdTurno=0;
int16 rTempProdAcu=0;
int16 rIniRecredo=0;
int16 rObjAcuTurnoAnt=0;

//colocados en funcion de como estan en la cadena de los shift registers
int8  rtemp=0;
//int8  pDig=0;  //puntero al digito a enviar al shift
//variables de la funcion de conversion a unidad decena y centena
int8  rUMil=0;
int8  rCent=0;
int8  rDec=0;
int8  rUni=0;


int8 dec_bcd[11]={0xC0,0xF9,0xA4,0xB0,0x99,0x92,0x82,0xF8,0x80,0x98,0xFF};//0x99 en 4

int8   rT1s=k1seg;
int8   rT100ms=k100ms;
int8   rMinIniRecDec=0; //minutos de inicio de recreo en la hora que hay recreo
int8   rMinFinTurnoDec=0; //minutos de fin de turno en la hora se inicia

//flag de teclado
int1  fTeclaOK=0;
int1  fIn1=0;
int1  fIn2=0;
int1  fIn3=0;
int1  fIn4=0;
int1  fIn5=0;
int1  fIn6=0;
int1  fTecOk=0;      //flag que la tecla ok se mantuvo apretada
int1  fTec1=0;
int1  fTec2=0;
int1  fTec3=0;
int1  fTec4=0;
int1  fTec5=0;
int1  fTec6=0;

//int1  fGuardarEEPROM=0;
int8  rInmunidad=0;
int8  rInmuniT1=0;
int8  rInmuniT2=0;
int8  rInmuniT3=0;
int8  rInmuniT4=0;
int8  rInmuniT5=0;
int8  rInmuniT6=0;


//variables de turno
/*
int8    rCantTurnos=0;
int8    rHoraIni=0;        //hora de inicio turno
int8    rMinutoIni=0;      //idem
int8    rHoraFin=0;        //hora de Fin turno
int8    rMinutoFin=0;      //idem
*/
int8    rUni_MinAnt=0;     //minuto anterior, para saber cuando cambio el minuto y controlar cambiio de turno

//VARIABLES DS1307
INT8  rDec_HS=0;
INT8  rUni_HS=0;
INT8  rDec_MIN=0;
INT8  rUni_MIN=0;
INT8  rDec_SEC=0;
INT8  rUni_SEC=0;
int8  rHora=0;       //hora actual
int8  rMinuto=0;     //minuto actual
int8  rSegundos=0;
int8  rp2=kP2;
int8  rHIniRec=0;    //hora de inicio del recreo segun el turno
int8  rMIniRec=0;    //Minutos de inicio del recreo segun el turno

int8  rHFinTurno=0;    //en esta hora finaliza el turno
//int8  rMFinTurno=0;    //Minutos de fin de turno

//VARIABLES para display
int8  rFiltro1=kFiltro;  //tiempo en segundos entre fin de prenda y fin de prenda
int8  rFiltro2=kFiltro;  //tiempo en segundos entre fin de prenda y fin de prenda
int8  rFiltro3=kFiltro;  //tiempo en segundos entre fin de prenda y fin de prenda
int8  rFiltro4=kFiltro;  //tiempo en segundos entre fin de prenda y fin de prenda
int8  rFiltro5=kFiltro;  //tiempo en segundos entre fin de prenda y fin de prenda
int8  rFiltro6=kFiltro;  //tiempo en segundos entre fin de prenda y fin de prenda

int1 p1seg=0;
int1 fFinHora=0;
int1 fIniTurno=0;
int1 fFinTurno=0;
int1 fTestTurno=0;
int1 f1Min=0;        //flag cada un minuto
int1 f100ms=0;
int1 fTimbre=0;      //hace sonar el timbre puesto en el rele 1
//int1 fHora=0;        //flag cada una hora
int1 fRecreo= 0;     //esta en recreo
int1 fAuxRecreo=0;
int1 fAlarma=0;
int1 fFinGrabar=0;
int1 fPantalla=0;    //para mostrar por un tiempo la pantalla 2
int1 fPantTemp=0;
int1 fFinRecreo=0;
int1 fIniRecreo=0;
//int1 rTempBool=0;
int1 fFiltro1=0;      //filtro para evitar que pulsen seguido el fin de prenda
int1 fFiltro2=0;      //filtro para evitar que pulsen seguido el fin de prenda
int1 fFiltro3=0;      //filtro para evitar que pulsen seguido el fin de prenda
int1 fFiltro4=0;      //filtro para evitar que pulsen seguido el fin de prenda
int1 fFiltro5=0;      //filtro para evitar que pulsen seguido el fin de prenda
int1 fFiltro6=0;      //filtro para evitar que pulsen seguido el fin de prenda

// librerias modbus
#include "modbus.h"
#include "modbus.c"

// Declaración de Funciones ///////////////////////////////////////////////////
void timbre(int16 patron);  
void envia_disp(void);                            
VOID ds1307_init(void);
void ds1307_read (void);
void ds1307_Write_time(int8 sec, int8 min, int8 hs);
void inc_dig(void);
void TestTurno(void);
void TestRecreo(void);
void Dec_A_UDCU(int16 nro);///descompone un numero en unidad mil, centena, decena y unidad
vOID WRITE_WORD_EEPROM(long int Dir, int16 data);
int16 READ_WORD_EEPROM(long int n);
void graba_EEPROM(void);
void lee_EEPROM(void);
void CalcProd(void);
void TestCambioOBJ (void);
void TestLeds(voiD);

//++++++++++++++++++ ESCANEO DE ENTRADAS ++++++++++++++++++++++++++++++
/*
   A0 = IN6
   A1 = IN5
   A2 = IN4
   A3 = IN3
   A4 = IN1
   A5 = IN2
*/
void  ScanInputs(){
   int rTempTec;                          //Temporal teclado
   rTempTec=input_A();
   
   if(input(pIn1))
      bit_set(rTempTec,4);
   else
      bit_clear(rTempTec,4);
      
   rTempTec=rTempTec & 0b00111111;
   if (!bit_test(rTempTec,0)){   //IN6
      if(--rInmuniT6==0 && !fTec6){
         rInmuniT6=kInmuni;;
         fIn6=1;
         fTec6=1;
      }
   }
   else{
      rInmuniT6=kInmuni;
      fTec6=0;
   }
   if (!bit_test(rTempTec,1)){   //IN5
      if(--rInmuniT5==0 && !fTec5){
         rInmuniT5=kInmuni;;
         fIn5=1;
         fTec5=1;
      }
   }
   else{
      rInmuniT5=kInmuni;
      fTec5=0;
   }
   if (!bit_test(rTempTec,2)){   //IN4
      if(--rInmuniT4==0 && !fTec4){
         rInmuniT4=kInmuni;;
         fIn4=1;
         fTec4=1;
      }
   }
   else{
      rInmuniT4=kInmuni;
      fTec4=0;
   }   
   if (!bit_test(rTempTec,3)){   //IN3
      if(--rInmuniT3==0 && !fTec3){
         rInmuniT3=kInmuni;;
         fIn3=1;
         fTec3=1;
      }
   }
   else{
      rInmuniT3=kInmuni;
      fTec3=0;
   }  
   if (!bit_test(rTempTec,4)){   //IN1
      if(--rInmuniT1==0 && !fTec1){
         rInmuniT1=kInmuni;;
         fIn1=1;
         fTec1=1;
      }
   }
   else{
      rInmuniT1=kInmuni;
      fTec1=0;
   } 
   if (!bit_test(rTempTec,5)){   //IN2
      if(--rInmuniT2==0 && !fTec2){
         rInmuniT2=kInmuni;;
         fIn2=1;
         fTec2=1;
      }
   }
   else{
      rInmuniT2=kInmuni;
      fTec2=0;
   }    
}
//++++++++++++++++++ ESCANEO DE ENTRADAS ++++++++++++++++++++++++++++++
/*
   A0 = IN6 = 62
   A1 = IN5 = 61
   A2 = IN4 = 59
   A3 = IN3 = 55
   A4 = IN1 = 47
   A5 = IN2 = 31
*/
void  ScanTeclado(){
//revision para placa nueva con teclado separado de placa principal
//
   int rTempTec;                          //Temporal teclado
//   set_tris_b (0b11111000);               //configuro entradas para teclas.
   rTempTec=input_A();
   if(input(pIn1))
      bit_set(rTempTec,4);
   else
      bit_clear(rTempTec,4);
      
   rTempTec=rTempTec & 0b00111111; //filtro
      if (rTempTec!=63 ) //si=0 ninguna tecla apretada... me voy
         {
         rInmunidad--;
            if(rInmunidad==0 && fTeclaOK==0){
               rInmunidad=kInmuni;
               switch (rTempTec){
                           case 62:fIn6=1;       //14
                                   fTeclaOK=1;
                                   break;
                           case 61:fIn5=1;
                                   fTeclaOK=1;
                                   break;
                           case 59:fIn4=1;
                                   fTeclaOK=1;
                                   break;
                           case 55:fIn3=1;
                                   fTeclaOK=1;
                                   break;
                           case 47:fIn1=1;
                                   fTeclaOK=1;
                                   break;
                           case 31:fIn2=1;
                                   fTeclaOK=1;
                                   break;                                   
                           default:fTeclaOK=0;
                                   rInmunidad=kInmuni;
                                   fIn1=0;
                                   fIn2=0;
                                   fIn3=0;
                                   fIn4=0;
                                   fIn5=0;
                                   fIn6=0;
                                   fTecOk=0;
                                   break;
                                 }
               }
            }
      else{
      rInmunidad=kInmuni;
      fTeclaOK=0;
      }
}


// INTERRUPCIONES /////////////////////////////////////////////////////////////
//++++++++++++++++++++++++++++++++++++++
//  RECEPCION SERIE.
//++++++++++++++++++++++++++++++++++++++
#int_rda
void serial_isr() {                    // Interrupción recepción serie USART
char rcvchar=0x00;
rcvchar=0x00;                        // Inicializo caracter recibido
   if(kbhit()){                           // Si hay algo pendiente de recibir ...
      rcvchar=getc();                     // lo descargo y ...
      ModBusRX(rcvchar);                // lo añado al buffer y ...
   }
   setup_timer_2 (T2_DIV_BY_16, 250, 16); //setup_timer_2 (T2_DIV_BY_4, 250, 16);
   output_low(pLedRX);
}

//++++++++++++++++++++++++++++++++++++++
//  TRANSMISION SERIE.
//++++++++++++++++++++++++++++++++++++++
#INT_TBE
void serial_tx(){
      ModBusTX();
}


//++++++++++++++++++++++++++++++++++++++
//  TIMER CERO.
//++++++++++++++++++++++++++++++++++++++
#int_RTCC
void RTCC_isr() {                // Interrupción Timer 0
set_timer0(60);
ScanInputs();
//scanteclado();
if (--rT1s==0){
   p1seg=1;
   rT1s=k1seg;
   if(fFiltro1){
      if(--rFiltro1==0){
         rFiltro1=kFiltro;
         fFiltro1=0;
      }
   }
   if(fFiltro2){
      if(--rFiltro2==0){
         rFiltro2=kFiltro;
         fFiltro2=0;
      }
   }
   if(fFiltro3){
      if(--rFiltro3==0){
         rFiltro3=kFiltro;
         fFiltro3=0;
      }
   }
   if(fFiltro4){
      if(--rFiltro4==0){
         rFiltro4=kFiltro;
         fFiltro4=0;
      }
   }
   if(fFiltro5){
      if(--rFiltro5==0){
         rFiltro5=kFiltro;
         fFiltro5=0;
      }
   }
   if(fFiltro6){
      if(--rFiltro6==0){
         rFiltro6=kFiltro;
         fFiltro6=0;
      }
   }   
}
if (--rT100ms==0 & !fRecreo){
   rAuxTiempo++;                    //incremento tiempo de prenda actual
   rAuxTiempo1++; 
   rAuxTiempo2++; 
   rAuxTiempo3++; 
   rAuxTiempo4++; 
   rT100ms=k100ms;
   f100ms=1;
}
}


///////// INTERRUPCION DEL TIMER 2  ////////////
// inactividad del bus 485
////////////////////////////////////////////////
#INT_TIMER2
void timer2_isr(){
int16 CRC=0;
int16 CRC_Leido=0;
output_high(pLedRX);
   if(fParami){                        //Calculo checksum de dato recibido
         CRC=CRC_Calc(rxbuff,rxpuntero-3); //
         CRC_Leido= make16(rxBuff[rxpuntero-2],rxBuff[rxpuntero-1]);
         if(CRC_Leido==CRC)flagcommand=1;
         setup_timer_2(T2_DISABLED,0,1);
         rxpuntero=0;
         }
   else{
         inicbuffRX();
         rxpuntero=0;
         }
} 


#int_TIMER1   //Timer 1 overflow
void TIMER1_int(){

}



//,,,,,,,,,,,,Programa Principal /////////////////////////////////////////////////////////

void main() {
   delay_ms(500);
   float N1=0;
   float N2=0;
   int8  rTemp=0;
   //int16 rTemp16=0;
   int8  rTempPant=0; //tiempo en segundos que queda la pantala de prod gral
//++++++++++++++++++Configura puertos analogicos++++++++++++++++++++++++++++++
   setup_adc(  ADC_OFF  );
   setup_adc_ports( NO_ANALOGS );                
//++++++++++++++++++       Configura timers     ++++++++++++++++++++++++++++++
   setup_comparator(NC_NC_NC_NC);               //no comparadores
   setup_timer_0(RTCC_INTERNAL|RTCC_DIV_256);   //desborda cada 10ms 256 antes
   setup_timer_2 (T2_DIV_BY_16, 250, 16);       //setup_timer_2 (T2_DIV_BY_4, 250, 16);

   //Seteos puertos
   set_tris_a (0b11111111);
   output_a(0);
   output_b(0);
   set_tris_b (0b00000000);
   output_c(0);
   set_tris_c (0b11011100);
   
   //********************************************
   ModbusAddress=104;//direccion modbus del cartel
   //********************************************
   
   rT1s=k1seg;
   rT100ms=k100ms;
   
   lee_EEPROM();
   rObjHsAnt=rObjHs;                            //igualo objetivo horario para saber cuando lo cambia
   
   set_timer0(60);
   enable_interrupts(int_rda);                  // Habilita Interrupción RDA
   enable_interrupts(int_RTCC);                 // Habilita Interrupción TIMER0
   enable_interrupts(int_TIMER2);               // Habilita Interrupción TIMER2   

   output_b(0);
   output_high(pOE_SR);
   output_low(pMR_SR);
   
   //output_high(pBUZZ);
   ds1307_init();
   delay_ms(30);
   output_high(pMR_SR);
   ds1307_read ();
   //inc_dig();
   //envia_disp();
   output_low(pBUZZ);
   output_high(pLedRX);
   output_high(pLedTX);
                   
   output_low(pOE_SR);
   rpantalla=0;
   enable_interrupts(global);  
   testleds();
   fFinGrabar=0;
   
   
   ////////////////////////////////////////////////////
   /////////         BUCLE PRINCIPAL         //////////
   ////////////////////////////////////////////////////
   
   do {
   rMinutosDec = rDec_Min*10 + rUni_Min;                 //extraigo minutos de la hora en decimal
   rMinIniRecDec=(rMiniRec >> 4)*10 +(rMiniRec & 0X0f);  //minutos de inicio del recreo
   rSetDate=rMinIniRecDec;
   
      //si se corto la energia
      if(!input(pin_a4) && !fFinGrabar){//& !fFinGrabar
         //output_high(pMR_SR);
         graba_EEPROM();
         output_high(pbuzz);
         fFinGrabar=1;
      }

      //se elimina tener que estar en recreo para contar prenda
      //pulsador fin prenda 1
      IF (fIN1 && bit_test(fEnPul,0)){
         fIN1=0;                 //reset flag
         if ( (rTurnoAct !=0) & !fFiltro1){ //!fRecreo &
               rProdHs++;              //incremento cantidad producida
               //rProdAcu++;             //incremento acumulado diario
               rProdTurno++;           //incremento acumulado turno
               rT_Pren1=rAuxTiempo1;  //guardo tiempo de ultima prenda
               rAuxTiempo1=0;
               fFiltro1=1;
               }
      }
      else if (!bit_test(fEnPul,0)){
         rAuxTiempo1=0;
         fIN1=0;           
      }
      
      //pulsador fin prenda 2
      IF (fIN2 && bit_test(fEnPul,1)){
         fIN2=0;                 //reset flag
         if ((rTurnoAct !=0) & !fFiltro2){ //!fRecreo & 
               rProdHs++;              //incremento cantidad producida
               //rProdAcu++;             //incremento acumulado diario
               rProdTurno++;           //incremento acumulado turno
               rT_Pren2=rAuxTiempo2;  //guardo tiempo de ultima prenda
               rAuxTiempo2=0;
               fFiltro2=1;
               }
      } 
      else if (!bit_test(fEnPul,1)){
         rAuxTiempo2=0;
         fIN2=0;           
      } 
      
      //pulsador fin prenda 3
      IF (fIN3 && bit_test(fEnPul,2)){
         fIN3=0;                 //reset flag
         if ((rTurnoAct !=0) & !fFiltro3){ //!fRecreo &
               rProdHs++;              //incremento cantidad producida
               //rProdAcu++;             //incremento acumulado diario
               rProdTurno++;           //incremento acumulado turno
               rT_Pren3=rAuxTiempo3;  //guardo tiempo de ultima prenda
               rAuxTiempo3=0;
               fFiltro3=1;
               } 
      }
      else if (!bit_test(fEnPul,2)){
         rAuxTiempo3=0;
         fIN3=0;           
      } 
      
      //pulsador fin prenda 4
      IF (fIN4 && bit_test(fEnPul,3)){
         fIN4=0;                 //reset flag
         if ((rTurnoAct !=0) & !fFiltro4){//!fRecreo &1500
               rProdHs++;              //incremento cantidad producida
               //rProdAcu++;             //incremento acumulado diario
               rProdTurno++;           //incremento acumulado turno
               rT_Pren4=rAuxTiempo4;  //guardo tiempo de ultima prenda
               rAuxTiempo4=0;
               fFiltro4=1;
               }
      } 
      else if (!bit_test(fEnPul,3)){
         rAuxTiempo4=0;
         fIN4=0;           
      }      
/*        //pulsador cambio pantalla
      IF (fIN2){
         fIN2=0;                 //reset flag
         if (rPantalla++ == 3)
               rPantalla = 0;
      }     */
     
      //si cambio el objetivo horario
      TestCambioOBJ();
      
      if(p1seg){
         p1seg=0;
         ds1307_read ();
         inc_dig();
         envia_disp();
      }    
      //calculos cada 1 minuto
      if (f1Min){
         f1Min=0;
         CalcProd();
         if (rPantalla==2){
            if(--rP2==0){
               rPantalla=0;
               rp2=kP2;
            }
         }
         if(rMinuto==0 && (rTurnoAct !=0))
            fFinHora=1;
      }
      
      //test para ver si cambio de turno
      //se ejecuta cada 1 minuto
      if(fTestTurno){
         fTestTurno=0;
         testTurno ();
         if (rTurnoAct != rTurnoAnt ){
            rTurnoAnt=rTurnoAct;
            //cambio de turno
            if ( rTurnoAct == 0) fFinTurno=1;           
            if(rTurnoAct !=0){
              fIniTurno=1;
            }
         }
         TestRecreo();
      }  
      
       //Suena el timbre al inicio y fin del recreo
      if (fRecreo != fAuxRecreo){
         fAuxRecreo= fRecreo;
         if (fRecreo==0) fFinRecreo=1;
         else fIniRecreo=1;
         fTimbre=1;
      }
      
 //termino turno
      if (fFinTurno){
         fFinTurno=0;
         rProdTurnoAnt=rProdTurno;
         rObjAcuTurnoAnt=rObjAcu;
         rProdTurno=0;
         fTimbre=1;
         rTempObjDia=rObjDia;
         rTempProdTurno=rProdTurnoAnt;
         rTempProdAcu=rProdAcu; 
         rPantalla=2;
         fFinHora=0;   //si fue fin de turno, no hacer fin de hora
      }   
      
      //inicio turno
      if (fIniTurno){
         rProdTurnoAnt=rProdTurno;
         fIniTurno=0;
         rAuxTiempo=0;
         rAuxTiempo1=0;
         rAuxTiempo2=0;
         rAuxTiempo3=0;
         rAuxTiempo4=0;
         fTimbre=1;
         rContMin=0;
         rProdHora=0;
         rProdHs=0;              //reset cantidad producida
         rProdAcu=0;             //reset acumulado diario
         rProdTurno=0;           //reset acumulado turno
         fFinHora=0;             //para que no calcule 2 veces el acumulado
         rDatoListo=0;           //para resetear y empezar a contar
         if (rMinutosDec !=0){
               N1=60-rMinutosDec;   //Tiempo productivo de la primer hora
               N1=N1/60;           //fraccion de la hora
               N2=(float)rObjHs;
               N2=N2 * N1;  //prop en lo que falta para fin de la hora con el nuevo objetivo
               rTempObjHs = (int16)N2;
               rObjAcu=rTempObjHs;
               }
         else{
               rObjAcu=rObjHs;
               rTempObjHs = rObjHs;
         }
      }   

      
//se cumplio una hora mas de produccion
      if (fFinHora){
         fFinHora=0;
         fIniRecreo=0;
         rProdHrAnt=rProdHs;//guardo cantidad producida en la hora anterior
         rTempObjHs = rObjHs;
         rProdHs=0;
         //rAuxTiempo=0;
         //calculo rendimiento acumulado
         CalcProd();
         //veo si en esta nueva hora hay recreo para calcular bien el obj acumulado
         if (rHora == rHIniRec){//si en esta hora esta el recreo, calculo cuanto pueden producir hasta el recreo
               N1=(float)rMinIniRecDec;//60;          //fraccion de la hora hasta que empiece el recreo
               N2=rObjHs * N1/60;               //prop en lo que falta para fin de la hora con el nuevo objetivo
               rTempObjHs = (int16)N2;        
               rObjAcu = rObjAcu+rTempObjHs;  //sumo nuevo acumulado para nueva hora
         }
         //veo si en esta nueva hora fin de turno, para cambiar objetivo
         else if (rHora == rHFinTurno){//si en esta hora esta el recreo, calculo cuanto pueden producir hasta el recreo
               N1=(float)rMinFinTurnoDec;//60;          //fraccion de la hora hasta que empiece el recreo
               N2=rObjHs * N1/60;               //prop en lo que falta para fin de la hora con el nuevo objetivo
               rTempObjHs = (int16)N2;        
               rObjAcu = rObjAcu+rTempObjHs;  //sumo nuevo acumulado para nueva hora
         }
         else{// en esta hora no hay recreo, cuento hora total
               rObjAcu = rObjAcu+rTempObjHs;  //sumo nuevo acumulado para nueva hora
               rTempObjHs = rObjHs;
         }
         fPantalla=1;
         rContMin=0;
         rDatoListo++;//=1; //le indica al scada que recolecte el dato
      }  
//si iniicio el recreo
//ejecutar esto solo si el recreo no inicia al mismo tiempo que el fin de una
//hora
      if (fIniRecreo){
         fIniRecreo=0;
         rProdHrAnt=rProdHs;//guardo cantidad producida en la hora anterior
         rProdHs=0;
         rDatoListo++;//=1; //le indica al scada que recolecte el dato
      }
      //si termino el recreo
      if (fFinRecreo){
      fFinRecreo=0;
      //tengo que ver si termino al inicio de la hora, si no, tengo que calcular los
      ///objetivos de la hora
         if(rMinutosDec != 0){                     //si termino distinto de cero, calculo objetivo hasta terminar esta hora
                                                   //si igual a cero, no hacer nada, porque se hace en fin de hora (creo)
               N1=(float)(60-rMinutosDec)/60;           //fraccion de la hora
               N2=(float)rObjHs * N1;              //prop en lo que falta para fin de la hora con el nuevo objetivo
               rTempObjHs = (int16)N2;  
               rObjAcu = rObjAcu+rTempObjHs;       //sumo nuevo acumulado para nueva hora
         }
      }
      
     
      //comunicacion modbus
       if(flagcommand){         // Si hay comando pendiente lo procesa
         ModBus_exe();        
         flagcommand=0;
         inicbuffRX();
         rxpuntero=0; 
      }
      //controla si cambio de turno
      if(rUni_MinAnt != rUni_Min){  //controla si cambio de turno solo si hay cambio en el minuto del reloj
         rUni_MinAnt=rUni_Min;      //asi esta rutina se ejecuta teoricamente cada 1 minuto
         fTestTurno=1;
         f1Min=1;
      }
      
   
      //comando enviado desde PC
      if (rCMD!=0)
      {
         switch (rCMD){
                  case 1: //ajustar hora
                        ds1307_Write_time(0x00, (int8)(rSetTime & 0x00ff), (int8)(rSetTime >>8));
                        break;
                  default:
                        break;       
         }//end switch CMD
         rCMD=0;
      } 
      
      //si hay que accionar el timbre
      if (fTimbre)
      {
         fAlarma=1;
         fTimbre=0;
         rTemp=rSegundos;
         rTemp +=3;
         if (rTemp >= 60)
            rTemp=rTemp-60;
      }
      //mostrar pantalla resumenes cada hora
      if (fPantalla)
      {
         rPantalla=1;
         fPantalla=0;
         fPantTemp=1;
         rTempPant = rSegundos + 10;
         if (rTempPant > 60)
            rtemppant= rtemppant-60;
      }
      
      //cambiar pantalla por 10 segundos
      if (fPantTemp){
         if(rTempPant == rSegundos){
            rPantalla=0;
            fPantTemp=0;
         }
      }
      //encender alarma y apagar pasado el tiempo configurado
      if (fAlarma){
         output_high(pBuzz);
         if(rTemp == rSegundos){
            output_low(pBuzz);
            fAlarma=0;
         }
      }
   } while (TRUE);//fin bucle infinito
}


//envio todos los datos al display
//20 bytes
void envia_disp(void){
int8 i=0;      //offset del puntero a enviar
int8 rbit=0;   //contador de bits
int8 Data=0;   //dato a enviar
//cargo el puntero con byte a enviar
for (i=0;i<=19;i++){//16
Data=*(&rMilL1+i);   //cargo el primer digito a enviar en DATA
//envio bit a bit el dato
   for (rbit=0;rbit<=7;rbit++){
      if(bit_test(Data,7))
         output_high(pDATA_SR);
      else
         output_low(pDATA_SR);
         
      rotate_left(&Data,1);
      delay_us(10);
      output_high(pDCLK_SR);  //CLOCK EN ALTO
      delay_us(10);
      output_LOW(pDCLK_SR);  //CLOCK EN BAJO
   }
}
output_high(pSCLK_SR);
delay_us(1);
output_low(pSCLK_SR);
output_high(pDATA_SR);
}

void inc_dig (void){
//int8 temp=0;
//1ra linea de digitos
switch (rPantalla){
      case 0:  //datos horarios 1 linea: cant horaria, 2 linea  obj horario, 3 linea: porcentaje
            Dec_A_UDCU(rProdHs);//rTempObjHs);//rTempObjHs);//Objetivo horario rObjHs
            rUniL1=dec_bcd[rUni];
            rDecL1=dec_bcd[rDec];
            rCenL1=dec_bcd[rCent];
            rMilL1=dec_bcd[rUMil];
            //2da linea de digitos
            Dec_A_UDCU(rTempObjHs);//objetivo horario
            rUniL2=dec_bcd[rUni];
            rDecL2=dec_bcd[rDec];
            rCenL2=dec_bcd[rCent];
            rMilL2=dec_bcd[rUMil];
            //3da linea de digitos
            Dec_A_UDCU(rProdAcu);//Productividad acumulada
            rUniL3=dec_bcd[rUni];
            rDecL3=dec_bcd[rDec];
            rCenL3=dec_bcd[rCent];
            rMilL3=dec_bcd[rUMil];
            //bit_clear(rUniL3,7);
            //cuarta linea de digitos (primera display compactos)            
            Dec_A_UDCU(rProdHora);//porcentaje producido
            rUniL4=dec_bcd[rUni];
            rDecL4=dec_bcd[rDec];
            rCenL4=dec_bcd[rCent];
            rMilL4=dec_bcd[rUMil];
            //bit_clear(rUniL3,7);
            //cuarta linea de digitos (primera display compactos)
            

            break;
      case 1: //datos diarios
            Dec_A_UDCU(rProdTurno);//rObjDia);//objetivo diario
            rUniL1=dec_bcd[rUni];
            rDecL1=dec_bcd[rDec];
            rCenL1=dec_bcd[rCent];
            rMilL1=dec_bcd[rUMil];
            //2da linea de digitos
            Dec_A_UDCU(rObjAcu);//produccion turno
            rUniL2=dec_bcd[rUni];
            rDecL2=dec_bcd[rDec];
            rCenL2=dec_bcd[rCent];
            rMilL2=dec_bcd[rUMil];
            //3da linea de digitos
            Dec_A_UDCU(rProdAcu);//productividad acumulada
            rUniL3=dec_bcd[rUni];
            rDecL3=dec_bcd[rDec];
            rCenL3=dec_bcd[rCent];
            rMilL3=dec_bcd[rUMil];
            //bit_clear(rUniL3,7);
            break;
      case 2: //datos diarios
            Dec_A_UDCU(rTempProdTurno);//temporal objetivo diario
            rUniL1=dec_bcd[rUni];
            rDecL1=dec_bcd[rDec];
            rCenL1=dec_bcd[rCent];
            rMilL1=dec_bcd[rUMil];
            //2da linea de digitos
            Dec_A_UDCU(rObjAcuTurnoAnt);//temporal produccion turno
            rUniL2=dec_bcd[rUni];
            rDecL2=dec_bcd[rDec];
            rCenL2=dec_bcd[rCent];
            rMilL2=dec_bcd[rUMil];
            //3da linea de digitos
            Dec_A_UDCU(rTempProdAcu);//productividad acumulada
            rUniL3=dec_bcd[rUni];
            rDecL3=dec_bcd[rDec];
            rCenL3=dec_bcd[rCent];
            rMilL3=dec_bcd[rUMil];
            //bit_clear(rUniL3,7);
            break;
      default:break;
}//fin switch
//4da linea de digitos (hora)
rUniL5=dec_bcd[rUni_Min];
rDecL5=dec_bcd[rDec_Min];
rCenL5=dec_bcd[rUni_HS];
rMilL5=dec_bcd[rDec_HS];
//leds pirania
//rLeds=dec_bcd[0];
rtemp=10;
if (bit_test(rUni_SEc,0))
   bit_set(rDecL5,7);
else
   bit_clear(rDecL5,7); //rCentL4
}

VOID ds1307_init(void){
int8 seconds=0;
   i2c_start();
   i2c_write(0xD0);
   i2c_write(0x00);
   i2c_start();
   i2c_write(0xD1);
   seconds = i2c_read(0);
   i2c_stop();
   seconds &= 0x7F;

   delay_us(3);

   i2c_start();
   i2c_write(0xD0);
   i2c_write(0x00);
   i2c_write(seconds);
   i2c_start();
   i2c_write(0xD0);
   i2c_write(0x07);
   i2c_write(0);
   i2c_stop();
}

void ds1307_read (void){
int8 rTempDS=0;
   I2C_Start();
   I2C_Write(0xd0); 
   i2c_write(0x00);
   I2C_Start();
   i2c_write(0xd1);
   rTempDS=i2c_read();//leo segundos 
   rUni_SEC= rTempDs & 0x0f;
   rDec_SEC= swap(rTempDS)& 0x0f; 
   rSegundos=(rDec_Sec*10)+rUni_Sec;//asumo que no es en BCD
   rTempDS=i2c_read();//leo minutos 
   rUni_Min= rTempDs & 0x0f;            
   rDec_Min= swap(rTempDS) & 0x0f;
   rMinuto= rDec_Min;
   rMinuto= rMinuto *16 + rUni_Min;
   rTempDS=i2c_read(0);//leo horas 
   rUni_HS= rTempDs & 0x0f;            
   rDec_HS= swap(rTempDS) & 0x03; 
   rHora= rDec_HS *16 + rUni_Hs;
   i2c_stop();
   rTime= rHora << 8;
   rTime=rTime + rMinuto;
}

void ds1307_Write_time(int8 sec, int8 min, int8 hs){
   i2c_start();
   i2c_write(0xD0);
   i2c_write(0x00);
   i2c_write(sec);
   //i2c_start();
   i2c_write(min);
   //i2c_start();
   i2c_write(hs);   
   i2c_start();
   i2c_write(0xD0);
   i2c_write(0x07);
   i2c_write(0);
   i2c_stop();
}

void TestTurno(void){
int8 rHini=0;
int8 rMini=0;
int8 rHfin=0;
int8 rMfin=0;
//controlo si esta turno 1
//hora inicio
rHini = make8(rIniT1,1);
rMini = make8(rIniT1,0);
//hora fin
rHfin = make8(rFinT1,1);
rMfin = make8(rFinT1,0);
if (rTurnoAct == 1){
   rHFinTurno =rHfin;
   rMinFinTurnoDec=(rMfin >> 4)*10 +(rMfin & 0X0f);  //minutos de fin de turno
}
//controlar inicio turno1
if ((rHora == rHini) & (rMinuto == rMini) & (rTurnoAct != 1)){
   rTurnoAct= 1;
   return;
}
//controlar fin turno 1
if (rTurnoAct == 1){
   if((rHora == rHfin) & (rMinuto == rMfin)){
      rTurnoAct= 0;
   }
}

//controlo si esta turno 2
//hora inicio
rHini = make8(rIniT2,1);
rMini = make8(rIniT2,0);
//hora fin
rHfin =make8(rFinT2,1);
rMfin = make8(rFinT2,0);
if (rTurnoAct == 2){
   rHFinTurno =rHfin;
   rMinFinTurnoDec=(rMfin >> 4)*10 +(rMfin & 0X0f);  //minutos de fin de turno
}
//controlar turno1
//controlar inicio turno1
if ((rHora == rHini) & (rMinuto == rMini) & (rTurnoAct != 2)){
   rTurnoAct= 2;
   return;
}
//controlar fir turno 1
if (rTurnoAct == 2){
   if((rHora == rHfin) & (rMinuto == rMfin)) rTurnoAct= 0;
}
//controlo si esta turno 3
//hora inicio
rHini = make8(rIniT3,1);
rMini = make8(rIniT3,0);
//hora fin
rHfin = make8(rFinT3,1);
rMfin =make8(rFinT3 ,0);
if (rTurnoAct == 3){
   rHFinTurno =rHfin;
   rMinFinTurnoDec=(rMfin >> 4)*10 +(rMfin & 0X0f);  //minutos de fin de turno
}
//controlar inicio turno1
if ((rHora == rHini) & (rMinuto == rMini) & (rTurnoAct != 3)){
   rTurnoAct= 3;
   return;
}
//controlar fir turno 1
if (rTurnoAct == 3){
   if((rHora == rHfin) & (rMinuto == rMfin)) rTurnoAct= 0;
}
//controlo si esta turno 4
//hora inicio

rHini = make8(rIniT4,1);
rMini = make8(rIniT4,0);
//hora fin
rHfin = make8(rFinT4,1);
rMfin =make8(rFinT4,0);
if (rTurnoAct == 4){
   rHFinTurno =rHfin;
   rMinFinTurnoDec=(rMfin >> 4)*10 +(rMfin & 0X0f);  //minutos de fin de turno
}
//controlar inicio turno4
if ((rHora == rHini) & (rMinuto == rMini) & (rTurnoAct != 4)){
   rTurnoAct= 4;
   return;
}
//controlar fir turno 4
if (rTurnoAct == 4){
   if((rHora == rHfin) & (rMinuto == rMfin)) rTurnoAct= 0;
}
//rTurnoAct= 0;
}

void TestRecreo(void){
int8 rHini=0;
int8 rMini=0;
int8 rHfin=0;
int8 rMfin=0;
//fRecreo= 0;
//hora inicio
if (rTurnoAct == 1){
   rHini = make8(rIniRecT1,1);
   rMini = make8(rIniRecT1,0);
   rHIniRec=rHini;
   rMIniRec=rMini;
   //hora fin
   rHfin = make8(rFinRecT1,1);
   rMfin = make8(rFinRecT1,0);
   //controlar recreo 1
/*   if ((rHora >= rHini) & (rMinuto >= rMini) & (rHora <= rHfin) & (rMinuto < rMfin)){
      fRecreo= 1;
      return;
   }*/
}
if (rTurnoAct == 2){
   //controlo si esta turno 2
   //hora inicio
   rHini = make8(rIniRecT2,1);
   rMini = make8(rIniRecT2,0);
   rHIniRec=rHini;
   rMIniRec=rMini;
   //hora fin
   rHfin = make8(rFinRecT2,1);
   rMfin = make8(rFinRecT2,0);
   //controlar recreo 2
/*   if ((rHora >= rHini) & (rMinuto >= rMini) & (rHora <= rHfin) & (rMinuto < rMfin)){
      fRecreo= 1;
       return;
   }*/
}
if (rTurnoAct == 3){
      //controlo si esta turno 3
   //hora inicio
   rHini = make8(rIniRecT3,1);
   rMini = make8(rIniRecT3,0);
   rHIniRec=rHini;
   rMIniRec=rMini;
   //hora fin
   rHfin = make8(rFinRecT3,1);
   rMfin = make8(rFinRecT3,0);
   //controlar recreo 3
/*   if ((rHora >= rHini) & (rMinuto >= rMini) & (rHora <= rHfin) & (rMinuto < rMfin)){
      fRecreo= 1;
       return;
   }*/
   
}
if (rTurnoAct == 4){
   //controlo si esta turno 4
   //hora inicio
   rHini = make8(rIniRecT4,1);
   rMini = make8(rIniRecT4,0);
   rHIniRec=rHini;
   rMIniRec=rMini;
   //hora fin
   rHfin = make8(rFinRecT4,1);
   rMfin = make8(rFinRecT4,0);
   //controlar recreo 4
/*   if ((rHora >= rHini) & (rMinuto >= rMini) & (rHora <= rHfin) & (rMinuto < rMfin)){
      fRecreo= 1;
      return;
   }*/
}
   if ((rHora == rHini) & (rMinuto >= rMini)){
      fRecreo= 1;
   }
   if ((rHora == rHfin) & (rMinuto >= rMfin)){
      fRecreo= 0;
   }   
   rIniRecredo = rMini;
}

//descompone un numero en unidad de mil, centena, decena y unidad
//retorna esos valores en variables globales rUMil, rCent, rDec, rUni
void Dec_A_UDCU(int16 nro){
if (nro > 9999)nro = 0;
rUMil = (int8)(nro/1000);
rCent = (int8)(nro/100 - rUMil*10);
rDec  = (int8)(nro/10 - rCent * 10 - rUmil *100);
rUni  = (int8)(nro - rUmil * 1000 - rCent *100 - rDec * 10);

if (rUMil == 0) rUMil = 10; // borrar cero
else return;
if (rCent == 0) rCent = 10; // borrar cero
else return; 
if (rDec == 0) rDec = 10; // borrar cero
else return;
}

vOID WRITE_WORD_EEPROM(long int Dir, int16 data) {
   int i;
   for (i = 0; i < 2; i++){
     write_eeprom(i + Dir, *((int8)&data + i) ) ;
   }
}

INT16 READ_WORD_EEPROM(long int n) {
   int i;
   int16 data;
   for (i = 0; i < 2; i++){
     *((int8)&data + i) = read_eeprom(i + n);
   }
   return(data);
}

void graba_EEPROM(void){
long int Data=0;
int8 EE_Add=0;    //direccion inicial en eeprom
Data= &rProdHs; //direccion de memoria en el micro.

for (EE_Add=0;EE_Add <=64;EE_Add ++){
   write_eeprom(EE_Add, *((int8)Data + EE_Add) ) ;

}//end for
WRITE_EEPROM(66,fEnPul);
//output_high(pBuzz);
}

void lee_EEPROM(void){
long int Data=0;
int8 EE_Add=0;    //direccion inicial en eeprom
Data= &rProdHs; //direccion de memoria en el micro.

for (EE_Add=0;EE_Add <=64;EE_Add ++){
  *((int8)Data + EE_Add)=read_eeprom(EE_Add) ;

}//end for
fEnPul=READ_EEPROM(66);
}

void CalcProd(void){
float N1=0;
float N2=0;
float rCalc=0;
         N1=(float)rProdHs;
         N2=(float)rTempObjHs;
         if (N2 > 0) rCalc = N1/N2;
         rProdHora = (int16)(rCalc*100); //SACO EL DECIMAL
         //productividad turno
         N1=(float)rProdTurno;
         N2=(float)rObjAcu;
         rCalc = N1/N2;         
         rProdAcu=(int16)(rCalc*100);//productuvidad acumulada  SE SACA EL DECIMAL, ANTES MULTIPLICADO POR 1000
}

void TestCambioOBJ (void){
int16 rTemp16=0;
float N1=0;
float N2 =0;
      if (rObjHsAnt != rObjHs){ 
         if(rTurnoAct!=0 & !fRecreo){
            rTemp16=rTempObjHs;
            if ((rHora == rHIniRec) & (rMinutosDec < rMIniRec))//si hay recreo en esta hora
                 N1= (float)rMinIniRecDec;
            else if (rHora == rHFinTurno)
                 N1= (float)rMinFinTurnoDec;
            else 
                 N1=60.0;  
                 
           N1 = (N1-(Float)rMinutosDec)/N1; 
           N2 = (float)rTempObjHs - (float)rObjHsAnt*N1 + (float)rObjHs * N1; 
           rTempObjHs=(int16)N2;
           rObjAcu = rObjAcu - rTemp16 + rTempObjHs;        
         }
         rObjHsAnt=rObjHs;       //igualo   
      }
}

void TestLeds(voiD){
int8 i=0;
do{
   if(f100ms){
      f100ms=0;
            rUniL1=dec_bcd[i];
            rDecL1=dec_bcd[i];
            rCenL1=dec_bcd[i];
            rMilL1=dec_bcd[i];
            rUniL2=rUniL1;
            rDecL2=rUniL1;
            rCenL2=rUniL1;
            rMilL2=rUniL1;
            rUniL3=rUniL1;
            rDecL3=rUniL1;
            rCenL3=rUniL1;
            rMilL3=rUniL1;
            rUniL4=rUniL1;
            rDecL4=rUniL1;
            rCenL4=rUniL1;
            rMilL4=rUniL1;
            rUniL5=rUniL1;
            rDecL5=rUniL1;
            rCenL5=rUniL1;
            rMilL5=rUniL1;            
      i++;
      envia_disp();
   }
}while (i<11);
   rDecL1=0xe3; //"v"
   rUniL1=dec_bcd[FwVer];
   Dec_A_UDCU ((int16)ModbusAddress);
   rUniL3=dec_bcd[rUni];
   rDecL3=dec_bcd[rDec];
   envia_disp();
   delay_ms(2000);
}
