/** @file  uapcmd.h
 *
 *  @brief This file contains declaration referring to
 *  functions defined in uapcmd.c
 *
 *
 * Copyright 2008-2022 NXP
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
    03/01/08: Initial creation
************************************************************************/

#ifndef _UAPCMD_H
#define _UAPCMD_H

/** Function Prototype Declaration */
int apcmd_sys_cfg_ap_mac_address(int argc, char *argv[]);
int apcmd_sys_cfg_ssid(int argc, char *argv[]);
int apcmd_sys_cfg_beacon_period(int argc, char *argv[]);
int apcmd_sys_cfg_dtim_period(int argc, char *argv[]);
int apcmd_sys_cfg_bss_status(int argc, char *argv[]);
int apcmd_sys_cfg_channel(int argc, char *argv[]);
int apcmd_sys_cfg_channel_ext(int argc, char *argv[]);
int apcmd_sys_cfg_scan_channels(int argc, char *argv[]);
int apcmd_sys_cfg_rates(int argc, char *argv[]);
int apcmd_sys_cfg_rates_ext(int argc, char *argv[]);
int apcmd_sys_cfg_tx_power(int argc, char *argv[]);
int apcmd_sys_cfg_bcast_ssid_ctl(int argc, char *argv[]);
int apcmd_sys_cfg_preamble_ctl(int argc, char *argv[]);
int apcmd_sys_cfg_rts_threshold(int argc, char *argv[]);
int apcmd_sys_cfg_frag_threshold(int argc, char *argv[]);
int apcmd_sys_cfg_radio_ctl(int argc, char *argv[]);
int apcmd_sys_cfg_rsn_replay_prot(int argc, char *argv[]);
int apcmd_sys_cfg_tx_beacon_rate(int argc, char *argv[]);
int apcmd_sys_cfg_mcbc_data_rate(int argc, char *argv[]);
int apcmd_sys_cfg_pkt_fwd_ctl(int argc, char *argv[]);
int apcmd_sys_cfg_sta_ageout_timer(int argc, char *argv[]);
int apcmd_sys_cfg_ps_sta_ageout_timer(int argc, char *argv[]);
int apcmd_sys_cfg_auth(int argc, char *argv[]);
int apcmd_sys_cfg_protocol(int argc, char *argv[]);
int apcmd_sys_cfg_wep_key(int argc, char *argv[]);
int apcmd_sys_cfg_cipher(int argc, char *argv[]);
int apcmd_sys_cfg_pwk_cipher(int argc, char *argv[]);
int apcmd_sys_cfg_gwk_cipher(int argc, char *argv[]);
int apcmd_sys_cfg_wpa_passphrase(int argc, char *argv[]);
int apcmd_sys_cfg_wpa3_sae_password(int argc, char *argv[]);
int apcmd_sys_cfg_group_rekey_timer(int argc, char *argv[]);
int apcmd_sta_filter_table(int argc, char *argv[]);
int apcmd_sys_cfg_max_sta_num(int argc, char *argv[]);
int apcmd_sys_cfg_retry_limit(int argc, char *argv[]);
int apcmd_sys_cfg_sticky_tim_config(int argc, char *argv[]);
int apcmd_sys_cfg_sticky_tim_sta_mac_addr(int argc, char *argv[]);
int apcmd_sys_cfg_eapol_pwk_hsk(int argc, char *argv[]);
int apcmd_sys_cfg_eapol_gwk_hsk(int argc, char *argv[]);
int apcmd_cfg_data(int argc, char *argv[]);
int apcmd_sys_cfg_wmm(int argc, char *argv[]);
int apcmd_sys_cfg_ap_wmm(int argc, char *argv[]);
int apcmd_sys_cfg_11n(int argc, char *argv[]);
int apcmd_sys_cfg_2040_coex(int argc, char *argv[]);
int apcmd_sys_cfg_restrict_client_mode(int argc, char *argv[]);
int apcmd_sys_cfg_wacp_mode(int argc, char *argv[]);
int apcmd_sys_cfg_ext_cap_len(int argc, char *argv[]);
#endif /* _UAP_H */
