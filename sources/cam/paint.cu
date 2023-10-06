/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   paint.c                                            :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: gamoreno <gamoreno@student.42.fr>          +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2023/02/21 22:24:35 by gamoreno          #+#    #+#             */
/*   Updated: 2023/04/07 18:23:52 by gamoreno         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "../../includes/minirt.h"

void	my_mlx_pixel_put(t_mrt *mrt, int x, int y, int color)
{
	char	*dst;

	if (!mrt->save && x < BORDER)
		color = diminish_color(color, 0.3);
	dst = mrt->addr + (y * mrt->sizel + x * (mrt->bpp / 8));
	*(unsigned int *)dst = color;
}

void __global__ ft_paint(void *data)
{
	t_mrt	*mrt;
	int		i;
	int		j;
	int		color;

	int index = threadIdx.x + blockIdx.x * blockDim.x;
	int stride = blockDim.x * gridDim.x;
	(void)index;
	(void)stride;
	mrt = (t_mrt *)data;
	i = 0;
	while (i < mrt->ix)
	{
		j = 0;
		// ft_percentage_bar(mrt);
		while (j < mrt->iy - 1)
		{
			color = get_pixel_color(mrt, i + 1, j + 1);
			my_mlx_pixel_put(mrt, i, j, color);
			j++;
		}
		i++;
	}
	// return (NULL);
}

void	pixel_calcul(t_mrt *mrt)
{
	int deviceId;
	int numberOfSMs;

	cudaGetDevice(&deviceId);
	cudaDeviceGetAttribute(&numberOfSMs, cudaDevAttrMultiProcessorCount, deviceId);
	
	size_t threadsPerBlock = 256;
	size_t numberOfBlocks = 32 * numberOfSMs;
	
	// t_mrt	*dat;
	// dat = ft_copy_mrt(mrt);
	
	ft_paint<<<threadsPerBlock, numberOfBlocks>>>(mrt);
	// int		i;

	// i = 0;
	// mrt->i = 0;
	// while (i < THREADS)
	// {
	// 	dat[i].i = i;
	// 	pthread_create(&mrt->threads[i], NULL, \
	// 	(void *)ft_paint, (void *)&dat[i]);
	// 	i++;
	// }
	// i = -1;
	// while (++i < THREADS)
	// 	pthread_join(mrt->threads[i], NULL);
	// if (mrt->first)
	// 	printf("\r[100%%]\n");
	// ft_free_mrt(dat, THREADS);
}
