/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   cylinder_utils2.c                                  :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: yridgway <yridgway@student.42.fr>          +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2023/04/04 03:58:18 by gamoreno          #+#    #+#             */
/*   Updated: 2023/04/07 15:41:29 by yridgway         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "../../includes/minirt.h"

t_vec	cyl_cap_nrml_fr_map(t_mrt *mrt, t_inter inter, t_vec c_cr, \
t_c_bump_val values)
{
	int		bump_coor[2];
	t_vec	ret;

	ret = fill_coord(0, 0, 1);
	if (values.i_diam > 6)
	{
		bump_coor[0] = (mrt->cylinder[inter.index].option.bump_map.height / 2) \
		+ (int)integer_part(c_cr.x / values.res_cap);
		bump_coor[1] = (mrt->cylinder[inter.index].option.bump_map.width / 2) \
		+ ((int)integer_part(c_cr.y / values.res_cap));
		//pthread_mutex_lock(mrt->mutexs);
		ret = bump_nrml_by_coor(&mrt->cylinder[inter.index].option, \
		bump_coor[0], bump_coor[1], 0.4);
		//pthread_mutex_unlock(mrt->mutexs);
	}
	return (ret);
}

double	get_angular_resol(t_mrt *mrt, t_inter inter, double r_c, int width)
{
	double	arc;
	int		i_res_c;
	int		n_img;
	double	ret;

	ret = r_c;
	arc = r_c / mrt->cylinder[inter.index].radius;
	i_res_c = (int)((2 * PI) / arc);
	n_img = i_res_c / (width - 1);
	if (n_img <= 0)
		ret = (2 * PI) / (width - 1);
	else
	{
		if (decimal_part((2 * PI) / n_img) <= 0.5)
			ret = (2 * PI) / (n_img * i_res_c);
		else
			ret = (2 * PI) / ((n_img + 1) * i_res_c);
	}
	return (ret);
}

double	get_body_resol(t_mrt *mrt, t_inter inter, double r_c, int height)
{
	int		i_res_h;
	int		n_img;
	double	ret;

	ret = r_c;
	i_res_h = (int)integer_part(mrt->cylinder[inter.index].height / r_c);
	n_img = i_res_h / (height - 1);
	if (n_img <= 0)
		ret = mrt->cylinder[inter.index].height / \
		(height - 1);
	else
	{
		if (decimal_part(mrt->cylinder[inter.index].height / n_img) <= 0.5)
			ret = mrt->cylinder[inter.index].height / (n_img * i_res_h);
		else
			ret = mrt->cylinder[inter.index].height / ((n_img + 1) * i_res_h);
	}
	return (ret);
}

t_vec	cyl_body_nrml_fr_map(t_mrt *mrt, t_inter inter, t_vec cyl_c, \
t_c_bump_val values)
{
	int		bump_coor[2];
	double	res_circ;
	double	res_h;
	t_vec	ret;

	ret = fill_coord(0, 0, 1);
	res_circ = get_angular_resol(mrt, inter, values.res_cap, \
	mrt->cylinder[inter.index].option.bump_map.width);
	res_h = get_body_resol(mrt, inter, values.res_cap, \
	mrt->cylinder[inter.index].option.bump_map.height);
	bump_coor[1] = (int)integer_part(cyl_c.y / res_circ) % \
	mrt->cylinder[inter.index].option.bump_map.width - 1;
	bump_coor[0] = (mrt->cylinder[inter.index].option.bump_map.height - 1) \
	- (int)integer_part((cyl_c.z + ((mrt->cylinder[inter.index].height) / 2)) \
	/ res_h) % (mrt->cylinder[inter.index].option.bump_map.height - 1);
	//pthread_mutex_lock(mrt->mutexs);
	ret = bump_nrml_by_coor(&mrt->cylinder[inter.index].option, \
	bump_coor[0], bump_coor[1], 0.4);
	//pthread_mutex_unlock(mrt->mutexs);
	return (ret);
}

t_vec	cyl_normal_from_map(t_mrt *mrt, t_inter inter, t_vec c_cr, t_vec cyl_cr)
{
	t_vec			ret;
	t_c_bump_val	values;

	values.i_diam = i_min_v(mrt->cylinder[inter.index].option.bump_map.height,
			mrt->cylinder[inter.index].option.bump_map.width);
	values.res_cap = (2 * mrt->cylinder[inter.index].radius) / (values.i_diam);
	ret = fill_coord(0, 0, 1);
	if (inter.cuad_ctr == 1 || inter.cuad_ctr == 2)
		ret = cyl_cap_nrml_fr_map(mrt, inter, c_cr, values);
	if (inter.cuad_ctr == 3)
		ret = cyl_body_nrml_fr_map(mrt, inter, cyl_cr, values);
	return (ret);
}
