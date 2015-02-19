from multiprocessing import Pool

def f():
	print('Hello!')

#pool=Pool(10)
#result=pool.apply_async(f)
#print(reault.get())
p=Process(target=f)
p.start()
p.join()
