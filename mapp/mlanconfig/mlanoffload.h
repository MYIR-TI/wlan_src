/** @file  mlanoffload.h
 *
 * @brief This files contains mlanconfig offload command handling.
 *
 *
 * Copyright 2008-2021 NXP
 *
 * NXP CONFIDENTIAL
 * The source code contained or described herein and all documents related to
 * the source code (Materials) are owned by NXP, its
 * suppliers and/or its licensors. Title to the Materials remains with NXP,
 * its suppliers and/or its licensors. The Materials contain
 * trade secrets and proprietary and confidential information of NXP, its
 * suppliers and/or its licensors. The Materials are protected by worldwide
 * copyright and trade secret laws and treaty provisions. No part of the
 * Materials may be used, copied, reproduced, modified, published, uploaded,
 * posted, transmitted, distributed, or disclosed in any way without NXP's prior
 * express written permission.
 *
 * No license under any patent, copyright, trade secret or other intellectual
 * property right is granted to or conferred upon you by disclosure or delivery
 * of the Materials, either expressly, by implication, inducement, estoppel or
 * otherwise. Any license under such intellectual property rights must be
 * express and approved by NXP in writing.
 *
 */
/************************************************************************
Change log:
     08/11/2009: initial version
************************************************************************/

#ifndef _MLANOFFLOAD_H_
#define _MLANOFFLOAD_H_

/** Key length */
#define KEY_LEN 32
/** Phrase length */
#define PHRASE_LEN 32
/** WEP Key count */
#define WEP_KEY_CNT 4

/* Bitmap for  OFFLoad Enable  - Feature*/
#ifdef BIG_ENDIAN_SUPPORT
/** Roaming Feature */
#define PROFILE_DB_FEATURE_ROAMING 0x8000
/** CCX Feature */
#define PROFILE_DB_FEATURE_CCX 0x4000
/** UNUSED Feature */
#define PROFILE_DB_FEATURE_UNUSED 0x2000
/** adhoc/infra mode */
#define PROFILE_DB_FEATURE_MODE 0x1000
#else
/** Roaming Feature */
#define PROFILE_DB_FEATURE_ROAMING 0x0001
/** CCX Feature */
#define PROFILE_DB_FEATURE_CCX 0x0002
/** UNUSED Feature */
#define PROFILE_DB_FEATURE_UNUSED 0x0004
/** adhoc/infra mode */
#define PROFILE_DB_FEATURE_MODE 0x0008
#endif

/* Bitmap for profile AKMP Support */
#ifdef BIG_ENDIAN_SUPPORT
/** Key Management EAP */
#define PROFILE_DB_KEY_MGMT_IEEE8021X 0x8000
/** Key Management PSK */
#define PROFILE_DB_KEY_MGMT_PSK 0x4000
/** Key Management NONE */
#define PROFILE_DB_KEY_MGMT_NONE 0x2000
/** Key Management CCKM */
#define PROFILE_DB_KEY_MGMT_CCKM 0x1000
/** Key Management UNUSED */
#define PROFILE_DB_KEY_MGMT_UNUSED 0x0800
/** Key Management FT 802.1x */
#define PROFILE_DB_KEY_MGMT_FT_IEEE8021X 0x0400
/** Key Management FT PSK */
#define PROFILE_DB_KEY_MGMT_FT_PSK 0x0200
/** Key Management SHA256 802.1x */
#define PROFILE_DB_KEY_MGMT_SHA256_IEEE8021X 0x0100
/** Key Management SHA256 PSK*/
#define PROFILE_DB_KEY_MGMT_SHA256_PSK 0x0080
#else
/** Key Management EAP */
#define PROFILE_DB_KEY_MGMT_IEEE8021X 0x0001
/** Key Management PSK */
#define PROFILE_DB_KEY_MGMT_PSK 0x0002
/** Key Management NONE */
#define PROFILE_DB_KEY_MGMT_NONE 0x0004
/** Key Management CCKM */
#define PROFILE_DB_KEY_MGMT_CCKM 0x0008
/** Key Management UNUSED */
#define PROFILE_DB_KEY_MGMT_UNUSED 0x0010
/** Key Management FT 802.1x */
#define PROFILE_DB_KEY_MGMT_FT_IEEE8021X 0x0020
/** Key Management FT PSK */
#define PROFILE_DB_KEY_MGMT_FT_PSK 0x0040
/** Key Management SHA256 802.1x */
#define PROFILE_DB_KEY_MGMT_SHA256_IEEE8021X 0x0080
/** Key Management SHA256 PSK*/
#define PROFILE_DB_KEY_MGMT_SHA256_PSK 0x0100
#endif

/* Bitmap for profile Encryption protocol support */
#ifdef BIG_ENDIAN_SUPPORT
/** Encryption protocol noRsn */
#define PROFILE_DB_PROTO_NO_RSN 0x8000
/** Encryption protocol static wep */
#define PROFILE_DB_PROTO_WEP_STATIC 0x4000
/** Encryption protocol dynamic wep */
#define PROFILE_DB_PROTO_WEP_DYNAMIC 0x2000
/** Encryption protocol WPA */
#define PROFILE_DB_PROTO_WPA 0x1000
/** Encryption protocol WPA-none
 *  Ad-hoc Networks */
#define PROFILE_DB_PROTO_WPA_NONE 0x0800
/** Encryption protocol WPA2 */
#define PROFILE_DB_PROTO_WPA2 0x0400
/** Encryption protocol CCKM */
#define PROFILE_DB_PROTO_CCKM 0x0200
#else
/** Encryption protocol noRsn */
#define PROFILE_DB_PROTO_NO_RSN 0x0001
/** Encryption protocol static wep */
#define PROFILE_DB_PROTO_WEP_STATIC 0x0002
/** Encryption protocol dynamic wep */
#define PROFILE_DB_PROTO_WEP_DYNAMIC 0x0004
/** Encryption protocol WPA */
#define PROFILE_DB_PROTO_WPA 0x0008
/** Encryption protocol WPA-none
 *  Ad-hoc Networks */
#define PROFILE_DB_PROTO_WPA_NONE 0x0010
/** Encryption protocol WPA2 */
#define PROFILE_DB_PROTO_WPA2 0x0020
/** Encryption protocol CCKM */
#define PROFILE_DB_PROTO_CCKM 0x0040
#endif

#ifdef BIG_ENDIAN_SUPPORT
/** Cipher wep40 */
#define PROFILE_DB_CIPHER_WEP40 0x80
/** Cipher wep104 */
#define PROFILE_DB_CIPHER_WEP104 0x40
/** Cipher tkip */
#define PROFILE_DB_CIPHER_TKIP 0x20
/** Cipher ccmp */
#define PROFILE_DB_CIPHER_CCMP 0x10
#else
/** Cipher wep40 */
#define PROFILE_DB_CIPHER_WEP40 0x01
/** Cipher wep104 */
#define PROFILE_DB_CIPHER_WEP104 0x02
/** Cipher tkip */
#define PROFILE_DB_CIPHER_TKIP 0x04
/** Cipher ccmp */
#define PROFILE_DB_CIPHER_CCMP 0x08
#endif

typedef struct {
	t_u16 startFreq;
	t_u8 chanWidth;
	t_u8 chanNum;

} __ATTRIB_PACK__ MrvlChannelDesc_t;

typedef struct {
	/** Header */
	MrvlIEtypesHeader_t header;

	t_u32 mode; /**< Mode */
	t_u32 max_off_channel; /**< Maximum off-channel measurement duration
				  (ms) */
	t_u32 max_on_channel; /**< Maximum on-channel measurement duration (ms)
			       */

} __ATTRIB_PACK__ MrvlIETypes_MeasTiming_t;

typedef struct {
	/** Action Set or get */
	t_u16 action;

	/** TLV buffer starts here */
	t_u8 tlv_buffer[1];

	/*
	 * MrvlIETypes_MeasTiming_t
	 */
} __ATTRIB_PACK__ HostCmd_DS_MEASUREMENT_Timing;

/** helper structure for profile parsing */
typedef struct {
	/** SSID name string */
	t_u8 ssid[IW_ESSID_MAX_SIZE + 1];
	/** SSID len */
	t_u32 ssid_len;
	/** BSSID network name */
	t_u8 bssid[ETH_ALEN];
	/** passphrase configured */
	t_s8 passphrase[PHRASE_LEN];
	/** passphrase length */
	t_u32 passphrase_len;
	/** Pre-shared key config flag */
	int psk_config;
	/** Pre-shared key */
	t_u8 psk[KEY_LEN];
	/** wep keys */
	t_u8 wep_key[WEP_KEY_CNT][KEY_LEN];
	/** wep keys lengths */
	t_u8 wep_key_len[WEP_KEY_CNT];
	/** wep key index */
	int wep_key_idx;
	/** protocol fields */
	t_u16 protocol;
	/** pairwise Cipher values */
	t_u8 pairwise_cipher;
	/** Group Cipher values */
	t_u8 groupwise_cipher;
	/** key management */
	t_u16 key_mgmt;
	/** offload specific parameter(roaming) */
	t_u16 roaming;
	/** offload specific parameter */
	t_u16 reserved;
	/** offload specific parameter--ccx */
	t_u16 ccx;
	/** offload specific parameter--mode */
	t_u16 mode;
} profile_entry_t;

typedef struct {
#ifdef BIG_ENDIAN_SUPPORT
	/** Reserved */
	t_u8 Reserved : 3;
	/** Channel not measured */
	t_u8 Unmeasured : 1;
	/** Radar detected */
	t_u8 Radar : 1;
	/** Unidentified signal received */
	t_u8 Unidentified : 1;
	/** OFDM Preamble received */
	t_u8 OFDM_Preamble : 1;
	/** BSS found */
	t_u8 BSS : 1;
#else
	/** BSS found */
	t_u8 BSS : 1;
	/** OFDM Preamble received */
	t_u8 OFDM_Preamble : 1;
	/** Unidentified signal received */
	t_u8 Unidentified : 1;
	/** Radar detected */
	t_u8 Radar : 1;
	/** Channel not measured */
	t_u8 Unmeasured : 1;
	/** Reserved */
	t_u8 Reserved : 3;
#endif
} __ATTRIB_PACK__ IEEEtypes_DFS_Map_t;

typedef struct {
	MrvlChannelDesc_t chanDesc; /**< Channel band, number */
	t_u32 millisecDwellTime; /**< Channel dwell time in milliseconds */
} __ATTRIB_PACK__ HostCmd_DS_CHAN_RPT_REQ;

typedef struct {
	t_u32 commandResult; /**< Rpt request command result (0 == SUCCESS) */
	t_u64 startTsf; /**< TSF Measurement started */
	t_u32 duration; /**< Duration of measurement in microsecs */

	t_u8 tlvBuffer[1]; /**< TLV Buffer */
} __ATTRIB_PACK__ HostCmd_DS_CHAN_RPT_RSP;

typedef struct {
	MrvlIEtypesHeader_t Header; /**< Header */

	t_u8 scanReqId; /**< Scan request id assigned in table */
} __ATTRIB_PACK__ MrvlIEtypes_ChanRptBcn_t;

typedef struct {
	MrvlIEtypesHeader_t Header; /**< Header */

	t_u8 ccaBusyFraction; /**< Parts per 255 channel was busy */
} __ATTRIB_PACK__ MrvlIEtypes_ChanRptChanLoad_t;

typedef struct {
	MrvlIEtypesHeader_t header; /**< Header */

	t_s16 anpi; /**< ANPI calculated from the histogram */
	/** RPI histogram bins. The number of bins utilized is variable and must
	    be calculated by the header length */
	t_u8 rpiDensities[11];
} __ATTRIB_PACK__ MrvlIEtypes_ChanRptNoiseHist_t;

typedef struct {
	MrvlIEtypesHeader_t Header; /**< Header */

	IEEEtypes_DFS_Map_t map; /**< IEEE 802.11h basic meas report */
} __ATTRIB_PACK__ MrvlIEtypes_ChanRpt11hBasic_t;

typedef struct {
	MrvlIEtypesHeader_t Header; /**< Header */

	t_u8 sourceAddr[ETH_ALEN]; /**< Source MAC */
	t_u8 bssid[ETH_ALEN]; /**< BSSID MAC */
	t_s16 rssi; /**< Avg RSSI of frames */
	t_u16 frameCnt; /**< # of frames */
} __ATTRIB_PACK__ MrvlIEtypes_ChanRptFrame_t;

#ifdef OPCHAN
typedef struct {
	MrvlIEtypesHeader_t header; /**< Header */

	MrvlChannelDesc_t chanDesc;

	t_u16 controlFlags;
	t_u16 reserved;

	t_u8 actPower;
	t_u8 mdMinPower;
	t_u8 mdMaxPower;
	t_u8 mdPower;

} __ATTRIB_PACK__ MrvlIEtypes_ChanControlDesc_t;

typedef struct {
#ifdef BIG_ENDIAN
	/** Reserved */
	t_u8 reserved_4_7 : 4;
	/** Disble channel filtering flag */
	t_u8 disable_chan_filt : 1;
	/** Channel scan mode passive flag */
	t_u8 passive_scan : 1;
	/** Multidomain scan mode */
	t_u8 multidomain_scan : 1;
	/** Enable probe response timeout */
	t_u8 rsp_timeout_en : 1;
#else
	/** Enable probe response timeout */
	t_u8 rsp_timeout_en : 1;
	/** Multidomain scan mode */
	t_u8 multidomain_scan : 1;
	/** Channel scan mode passive flag */
	t_u8 passive_scan : 1;
	/** Disble channel filtering flag */
	t_u8 disable_chan_filt : 1;
	/** Reserved */
	t_u8 reserved_4_7 : 4;
#endif
} __ATTRIB_PACK__ ChanScanMode_t;

typedef struct {
	MrvlIEtypesHeader_t header; /**< Header */

	t_u32 chanGroupBitmap;
	ChanScanMode_t scanMode;
	t_u8 numChan;

	MrvlChannelDesc_t chanDesc[50];

} __ATTRIB_PACK__ MrvlIEtypes_ChanGroupControl_t;

typedef struct {
	t_u16 action; /**< CMD Action Get/Set*/

	t_u8 tlv_buffer[1];

} __ATTRIB_PACK__ HostCmd_DS_OPCHAN_CONFIG;

typedef struct {
	t_u16 action; /**< CMD Action Get/Set*/

	t_u8 tlv_buffer[1];

} __ATTRIB_PACK__ HostCmd_DS_OPCHAN_CHANGROUP_CONFIG;
#endif

typedef struct {
	t_u8 modGroup;
	t_u8 txPower;

} __ATTRIB_PACK__ MrvlChanTrpcEntry_t;

typedef struct {
	MrvlIEtypesHeader_t header; /**< Header */

	MrvlChannelDesc_t chanDesc;
	MrvlChanTrpcEntry_t chanTrpcEntry[1];

} __ATTRIB_PACK__ MrvlIEtypes_ChanTrpcCfg_t;

typedef struct {
	t_u16 action; /**< CMD Action Get/Set*/
	t_u16 reserved;

	t_u8 tlv_buffer[1]; /** MrvlIEtypes_ChanTrpcCfg_t TLVs */

} __ATTRIB_PACK__ HostCmd_DS_CHAN_TRPC_CONFIG;

typedef struct {
	t_u8 controlSelect;

	t_u8 controlBitmap[1]; /* Variable length # of byte bitmaps */

} __ATTRIB_PACK__ HostCmd_DS_OFFLOAD_FEATURE_CONTROL;

#define IAPP_DATA_MAX 1000

/**
 *  @brief Enumeration for the command result from an IAPP Proxy command
 */
typedef enum {
	IAPP_PROXY_RESULT_SUCCESS = 0,
	IAPP_PROXY_RESULT_EXEC_FAILURE = 1,
	IAPP_PROXY_RESULT_TIMEOUT = 2,
	IAPP_PROXY_RESULT_DATA_INVALID = 3,
} __ATTRIB_PACK__ mlan_iapp_proxy_result_e;

typedef struct {
	mlan_iapp_proxy_result_e commandResult; /**< Firmware execution result
						 */

	t_u32 timeout_ms; /**< Timeout value in milliseconds */

	t_u8 iappType;
	t_u8 iappSubType;

	t_u32 iappDataLen;
	t_u8 iappData[IAPP_DATA_MAX];

} __ATTRIB_PACK__ HostCmd_DS_IAPP_PROXY;

typedef struct {
	/** Action: GET/SET */
	t_u16 Action;
	/** Reserved */
	t_u16 Reserved;
	/** Association timeout */
	t_u32 AssocTimeout;
	/** Reassociation timeout */
	t_u32 ReassocTimeout;
	/** Hand shake timeout */
	t_u32 HandShakeTimeout;
	/** Frame exchange timeout */
	t_u32 FrameExchangeTimeout;
	/** Deauth of old AP in millisec; 0 to disable */
	t_u32 PriorApDeauthDelay;
	/** Maximum time after a disconnect where a reassoc frame will be sent
	 */
	t_u32 ReassocDiscMax;
} __ATTRIB_PACK__ HostCmd_DS_AssociationTiming_t;

/** 16 bit unsigned integer */
typedef t_u16 IEEEtypes_AId_t;
/** 16 bit unsigned integer */
typedef t_u16 IEEEtypes_StatusCode_t;

typedef struct {
	/** Capability information */
	IEEEtypes_CapInfo_t Capability;
	/** Association response status code */
	IEEEtypes_StatusCode_t StatusCode;
	/** Association ID */
	IEEEtypes_AId_t AId;
	/** IE data buffer */
	t_u8 IEBuffer[1];
} __ATTRIB_PACK__ IEEEtypes_AssocRsp_t;

/** Maximum number of AC QOS queues available in the driver/firmware */
#define MAX_AC_QUEUES 4

typedef struct {
	t_u32 timeSinceLastQuery_ms; /**< Duration of stats collection */

	t_u16 bcnCnt; /**< Number of beacons received */
	t_u16 bcnMiss; /**< Estimate of beacons missed */
	t_s16 bcnRssiAvg; /**< Avg beacon RSSI */
	t_s16 bcnSnrAvg; /**< Avg beacon SNR */

	t_u32 rxPkts; /**< Number of packets received */
	t_s16 rxRssiAvg; /**< Avg received packet RSSI */
	t_s16 rxSnrAvg; /**< Avg received packet SNR */

	t_u32 txPkts; /**< Number of packets transmitted */
	t_u32 txAttempts; /**< Number of attempts made */
	t_u32 txFailures; /**< Number of pkts that failed */
	t_u8 txInitRate; /**< Current rate adaptation TX rateid */
	t_u8 reserved[3]; /**< Reserved */

	t_u16 txQueuePktCnt[MAX_AC_QUEUES]; /**< Number of packets per AC */
	t_u32 txQueueDelay[MAX_AC_QUEUES]; /**< Averge queue delay per AC*/
} __ATTRIB_PACK__ HostCmd_DS_LINK_STATS_SUMMARY;

/** timing select structure */
typedef struct {
	char *str; /**< Timing mode string */
	int match_len; /**< match length */
	t_u8 sel; /**< flag */

} timing_sel_t;

/** ENUM definition: reg_chan_table */
typedef enum {
	REGTABLE_DEFAULT = 0,
	REGTABLE_ESS = 1,
	REGTABLE_USER = 2,
	REGTABLE_MULTIDOMAIN = 3,

	REGTABLE_MAX = 0xFFFF,
} reg_chan_table_e;

/** Sub-command callback */
typedef int (*sub_cmd_callback_t)(int argc, char *argv[]);

/** Sub-command execution data */
typedef struct {
	char *str; /**< Command string */
	int match_len; /**< Length */
	int display; /**< display as valid cmd */
	sub_cmd_callback_t callback; /**< Sub-command callback */

} sub_cmd_exec_t;

/**  HostCmd_CMD_802_11_RF_TX_POWER */
typedef struct {
	t_u16 action;
	t_s16 current_level;
	t_s8 max_power;
	t_s8 min_power;

} __ATTRIB_PACK__ HostCmd_DS_802_11_RF_TX_POWER;

/**  HostCmd_CMD_802_11_AUTHENTICATE */
typedef struct {
	/** MAC address */
	t_u8 MacAddr[ETH_ALEN];
	/** Authentication type */
	t_u8 AuthType;
} __ATTRIB_PACK__ HostCmd_DS_802_11_AUTHENTICATE;

boolean reg_class_table_select(char *tableStr, reg_chan_table_e *pTable);
int process_sub_cmd(sub_cmd_exec_t *sub_cmd, int num_sub_cmds, int argc,
		    char *argv[]);
int process_regclass(int argc, char *argv[]);
int process_scanagent(int argc, char *argv[]);
int process_measurement(int argc, char *argv[]);
int process_profile_entry(int argc, char *argv[]);
int process_get_ra_config(int argc, char *argv[]);
int process_set_ra_config(int argc, char *argv[]);
int process_chanrpt(int argc, char *argv[]);
int process_chan_graph(int argc, char *argv[]);
int process_assoc_timing(int argc, char *argv[]);
int process_get_assocrsp(void);
int process_link_stats(int argc, char *argv[]);

int process_opchan(int argc, char *argv[]);
int process_changroup(int argc, char *argv[]);
int process_fcontrol(int argc, char *argv[]);
int process_iapp(int argc, char *argv[]);
int process_dscpmap(int argc, char *argv[]);
int process_rf_tx_power(int argc, char *argv[]);
int process_authenticate(int argc, char *argv[]);
int process_txpowdisp(int argc, char *argv[]);
int process_tsf(int argc, char *argv[]);

#endif /* _MLANOFFLOAD_H_ */
