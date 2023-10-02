/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   paint_utils.c                                      :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: yridgway <yridgway@student.42.fr>          +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2023/04/01 21:16:00 by yridgway          #+#    #+#             */
/*   Updated: 2023/04/05 04:09:44 by yridgway         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "../../includes/minirt.h"

// void	ft_percentage_bar(t_mrt *mrt)
// {
// 	double	percent;

// 	if (mrt->first)
// 	{
// 		pthread_mutex_lock(mrt->mutexs);
// 		percent = (double)*mrt->percent / (mrt->ix * THREADS) * 100;
// 		printf("\r[%.0f%%]", percent);
// 		(*mrt->percent)++;
// 		pthread_mutex_unlock(mrt->mutexs);
// 	}
// }

void	ft_copy_mem(t_mrt *mrt, t_mrt *dat)
{
	dat->light = (t_light*)ft_memcpy(mrt->light, mrt->obj_count[LIGHT] * sizeof(t_light));
	if (mrt->sphere)
		dat->sphere = \
		(t_sphere*)ft_memcpy(mrt->sphere, mrt->obj_count[SPHERE] * sizeof(t_sphere));
	if (mrt->plane)
		dat->plane = \
		(t_plane*)ft_memcpy(mrt->plane, mrt->obj_count[PLANE] * sizeof(t_plane));
	if (mrt->cylinder)
		dat->cylinder = \
		(t_cylinder*)ft_memcpy(mrt->cylinder, mrt->obj_count[CYLINDER] * sizeof(t_cylinder));
	if (mrt->cone)
		dat->cone = (t_cone*)ft_memcpy(mrt->cone, mrt->obj_count[CONE] * sizeof(t_cone));
	if (mrt->triangle)
		dat->triangle = \
		(t_triangle*)ft_memcpy(mrt->triangle, mrt->obj_count[TRIANGLE] * sizeof(t_triangle));
	dat->curr_obj = mrt->curr_obj;
	dat->scene_path = mrt->scene_path;
	dat->obj_count = \
	(int*)ft_memcpy(mrt->obj_count, mrt->num_objs * sizeof(int));
}

t_mrt	*ft_copy_mrt(t_mrt *mrt, int num)
{
	int		i;
	t_mrt	*dat;

	i = -1;
	dat = (t_mrt*)ft_malloc(sizeof(t_mrt) * num);
	while (++i < num)
	{
		ft_set_mrt(&dat[i], "unset", 0, 0);
		dat[i].save = mrt->save;
		dat[i].addr = mrt->addr;
		dat[i].bpp = mrt->bpp;
		dat[i].endi = mrt->endi;
		dat[i].sizel = mrt->sizel;
		dat[i].mutexs = &mrt->mutex;
		dat[i].first = mrt->first;
		dat[i].num_objs = mrt->num_objs;
		dat[i].bounce = mrt->bounce;
		dat[i].ix = mrt->ix;
		dat[i].iy = mrt->iy;
		dat[i].amblight = mrt->amblight;
		dat[i].cam = mrt->cam;
		dat[i].percent = &mrt->i;
		ft_copy_mem(mrt, &dat[i]);
	}
	return (dat);
}

void	ft_free_mrt(t_mrt *mrt, int num)
{
	int	i;

	i = -1;
	while (++i < num)
	{
		ft_free(mrt[i].light);
		ft_free(mrt[i].sphere);
		ft_free(mrt[i].plane);
		ft_free(mrt[i].cylinder);
		ft_free(mrt[i].cone);
		ft_free(mrt[i].triangle);
		ft_free(mrt[i].obj_count);
		ft_free(mrt[i].scene_path);
	}
	ft_free(mrt);
}
