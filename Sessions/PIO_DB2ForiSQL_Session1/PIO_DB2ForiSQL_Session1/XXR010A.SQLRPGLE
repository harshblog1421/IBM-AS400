000200000000**Free
000201000000
000300000000  ctl-opt DFTACTGRP(*NO) ACTGRP('UTSTATUS')
000400000000   ALWNULL(*USRCTL);
000500000000
000600000000  //*---------------------------------------------------------------*
000700000000  //*   THIS MATERIAL IS LICENSED VISION-C CONSULTING INC. (VCCI)   *
000800000000  //*---------------------------------------------------------------*
000900000000  //*                                                               *
001000000000  //* DESIGNED BY: Hiram Hubbard                                    *
001100000000  //*                                                               *
001200221128  //*  PROGRAM ID: XXR010A.SQLRPG                                   *
001300000000  //*                                                               *
001400000000  //*  Decription: This is a sample program to show how to do       *
001500000000  //*              blocked SQL update data with Parallel using SMP  *
001600000000  //*                                                               *
001700000000  //* Example ONLY  (Training)                                     *
001800000000  //*                                                               *
001900000000  //*****************************************************************
002100000000  //* All rights reserved.                                          *
002200000000  //*                                                               *
002300000000  //* Licensed Materials - Property of VCCI                         *
002400000000  //*****************************************************************
002500000000  //*****************************************************************
002600000000  //*    MOD NO    INIT  DATE   DESCRIBE BASIC CHANGE               *
002700000000  //* ***********  ***  ******  *************************************
002800000000  //*              HLH 01/2021  Initial Write                       *
002900000000  //*****************************************************************
003600000000
003700000000  //*-------------------------------------------------------------*
003800000000  //*    Prototype for this program *Entry Point                  *
003900000000  //*-------------------------------------------------------------*
004000000000
004100221128       Dcl-PI XXR010A;
004200000000             i_From_RRN      PACKED(15:5);
004300000000             i_To_RRN        PACKED(15:5);
004400000000       End-PI;
004500000000
004600000000
004700000000  //*------------------------------------------------------------*
004800000000  //*    Set compile option                                      *
004900000000  //*------------------------------------------------------------*
005000000000
005100000000            exec sql  Set Option
005200000000                 COMMIT    = *NONE,
005300000000                 USRPRF    = *OWNER, DYNUSRPRF = *OWNER,
005400000000                 DATFMT    = *ISO,   DLYPRP    = *YES,
005500000000                 CLOSQLCSR = *ENDACTGRP;
005600000000
005700000000  //*------------------------------------------------------------*
005800000000  //*    Purpose: Update TABLE Status with row number range      *
005900000000  //*------------------------------------------------------------*
006000000000
006100000000         exec sql
006200000000
006300000000             update INSVMST set idsccd = 'P' where inumbr in (
006400000000              select sku from aw_2_b_pur a
006500000000              where rrn(a) between :i_From_RRN and :i_To_RRN);
006700000000
006800000000          *Inlr = *on;
006900000000          Return;
007000000000
