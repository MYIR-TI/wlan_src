/** @file mlan_11ac.h
 *
 *  @brief This file defines the private and adapter data
 *  structures and declares global function prototypes used
 *  in MLAN module.
 *
 *
 *  Copyright 2011-2021 NXP
 *
 *  NXP CONFIDENTIAL
 *  The source code contained or described herein and all documents related to
 *  the source code (Materials) are owned by NXP, its
 *  suppliers and/or its licensors. Title to the Materials remains with NXP,
 *  its suppliers and/or its licensors. The Materials contain
 *  trade secrets and proprietary and confidential information of NXP, its
 *  suppliers and/or its licensors. The Materials are protected by worldwide
 *  copyright and trade secret laws and treaty provisions. No part of the
 *  Materials may be used, copied, reproduced, modified, published, uploaded,
 *  posted, transmitted, distributed, or disclosed in any way without NXP's
 *  prior express written permission.
 *
 *  No license under any patent, copyright, trade secret or other intellectual
 *  property right is granted to or conferred upon you by disclosure or delivery
 *  of the Materials, either expressly, by implication, inducement, estoppel or
 *  otherwise. Any license under such intellectual property rights must be
 *  express and approved by NXP in writing.
 *
 *  Alternatively, this software may be distributed under the terms of GPL v2.
 *  SPDX-License-Identifier:    GPL-2.0
 *
 *
 */

#ifndef _MLAN_11AC_H_
#define _MLAN_11AC_H_

#include "mlan_11n_aggr.h"
#include "mlan_11n_rxreorder.h"
#include "mlan_wmm.h"

void wlan_show_dot11acdevcap(pmlan_adapter pmadapter, t_u32 cap);
void wlan_show_dot11acmcssupport(pmlan_adapter pmadapter, t_u32 support);
t_u16 wlan_convert_mcsmap_to_maxrate(mlan_private *priv, t_u16 bands,
				     t_u16 mcs_map);
void wlan_fill_vht_cap_tlv(mlan_private *priv, MrvlIETypes_VHTCap_t *pvht_cap,
			   t_u16 bands, t_u8 flag, t_u8 bw_80p80);
void wlan_fill_vht_cap_ie(mlan_private *priv, IEEEtypes_VHTCap_t *pvht_cap,
			  t_u16 bands);
void wlan_fill_tdls_vht_oprat_ie(mlan_private *priv,
				 IEEEtypes_VHTOprat_t *vht_oprat,
				 sta_node *sta_ptr);
t_u8 wlan_is_ap_in_11ac_mode(mlan_private *priv);
int wlan_cmd_append_11ac_tlv(mlan_private *pmpriv, BSSDescriptor_t *pbss_desc,
			     t_u8 **ppbuffer);
mlan_status wlan_11ac_cfg_ioctl(pmlan_adapter pmadapter,
				pmlan_ioctl_req pioctl_req);
void wlan_update_11ac_cap(mlan_private *pmpriv);
t_u8 wlan_11ac_bandconfig_allowed(mlan_private *pmpriv, t_u16 bss_band);
t_u8 wlan_is_80_80_support(mlan_private *pmpriv, BSSDescriptor_t *pbss_desc);

mlan_status wlan_cmd_11ac_cfg(pmlan_private pmpriv, HostCmd_DS_COMMAND *cmd,
			      t_u16 cmd_action, t_void *pdata_buf);

mlan_status wlan_ret_11ac_cfg(pmlan_private pmpriv, HostCmd_DS_COMMAND *resp,
			      mlan_ioctl_req *pioctl_buf);

#endif /* _MLAN_11AC_H_ */
