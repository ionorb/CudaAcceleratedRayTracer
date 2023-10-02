/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   math2.c                                            :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: ana <ana@student.42.fr>                    +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2023/02/21 22:28:00 by gamoreno          #+#    #+#             */
/*   Updated: 2023/03/05 21:21:23 by ana              ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "../../includes/minirt.h"

t_vec	vec_sum(t_vec v1, t_vec v2)
{
	t_vec	res;

	res.x = v1.x + v2.x;
	res.y = v1.y + v2.y;
	res.z = v1.z + v2.z;
	return (res);
}

t_vec	scal_vec(double scalar, t_vec vector)
{
	t_vec	ret;

	ret.x = scalar * vector.x;
	ret.y = scalar * vector.y;
	ret.z = scalar * vector.z;
	return (ret);
}

double	min_v(double d1, double d2)
{
	if (d1 >= d2)
		return (d2);
	return (d1);
}

double	v_abs(double x)
{
	if (x < 0)
		return (-x);
	else
		return (x);
}

double	dot_prod(t_vec v1, t_vec v2)
{
	return ((v1.x * v2.x) + (v1.y * v2.y) + (v1.z * v2.z));
}
